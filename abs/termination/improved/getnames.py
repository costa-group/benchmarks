# -*- coding: utf-8 -*-

import re
from subprocess import check_output
import os

COSTABS_BIN = '/home/kike/Systems/costa/costabs/src/interfaces/shell/costabs'
FNULL = open(os.devnull, 'w')

# Obtiene una lista de nombres de método a partir de un fichero con los 
# resultados del coste RelyGuarantee
def get_names( filename ):
    p = re.compile("UB for ([a-zA-Z0-9.]*):")
    f = open(filename, 'r')
    cad = f.read()
    l = p.findall(cad)    
    f.close()
    
    return l
    
    
# Obtiene los nombres de metodos a partir de la salida del coste rely-guarantee
# desde el metodo inicial   
def get_method_names(program, entry='Main.main'):
    command = COSTABS_BIN + ' ' + program + ' -entries ' + entry + " -cost_model steps -rely_guarantee yes"
    output = check_output([command], stderr=FNULL, shell=True)
    #print output
    p = re.compile("UB for (.*): .*\n")
    p2 = re.compile("(.+) non-terminating")
    l = p.findall(output)
    l2 = p2.findall(output)
    return l + l2
    

def get_termination_rg(program, entry='Main.main'):
    command = COSTABS_BIN + ' ' + program + ' -entries ' + entry + " -cost_model termination -rely_guarantee yes"
    output = check_output([command], stderr=FNULL,shell=True)
    #print '***', output, '***'
    p = re.compile("(SCC# \d+).+(\[.+\])\s+(.+)\n")
    ptime = re.compile("Rely-guarantee termination analysis in (\d+) ms.")
    l = p.findall(output)
    l2 = ptime.findall(output)
    
    d = dict()
    num_term = 0
    total_scc = len(l)
    for (a,b,c) in l:
        if c == "Terminating":
            num_term += 1
        d[(a,b)] = (c == "Terminating")
        
    return (total_scc, num_term, l2[0], d)
    
    
def get_termination_original(program, entries=None):
    if entries == None:
        entries = get_method_names(program)
    #print entries
    command = COSTABS_BIN + ' ' + program + ' -entries ' + " ".join(entries) + " -cost_model termination -rely_guarantee no"
    output = check_output([command], stderr=FNULL, shell=True)
    p = re.compile("Method (.+) terminates\?: (\w+)")
    ptime = re.compile("in (\d+) ms.")
    #    Method Env.numH terminates?: YES
    #print output
    d = dict()
    num_term = 0
    for (a,b) in p.findall(output):
        if b == "YES":
            num_term += 1
        d[a] = (b == "YES")
    total_methods = (len(entries),len(d))
    times = ptime.findall(output)
    total_time = sum(map(int, times))
    
    return (total_methods, num_term, total_time, d)
     
    
    
def is_valid_ub(ub):
    return ("maximize_failed" not in ub) and ("no_rf" not in ub) and ("non-terminating" not in ub) and ("max_failure" not in ub)
    
    
def quita_comillas(e):  
    if e[0] == "'": 
        e = e [1:]
    if e[-1] == "'":
        e = e[:-1]
    return e    
  
  
def pretty_ubs(dub, entries=[]):
    text = ""
    dict_lines = dict() #para mantener el orden de entries
    
    for k in dub:
        pos_parentesis = k.index("(")
        clean_k = k[:pos_parentesis]
        clean_k = quita_comillas(clean_k)
        symbol = "-"  
        print k
        if is_valid_ub(dub[k]):
            symbol = "+"
        dict_lines[entries.index(clean_k)] = "{0} UB for {1} = {2}\n".format(symbol, clean_k, dub[k])
        
    for k in dict_lines:
        text += dict_lines[k]
        
    return text
    
    
def pretty_dubs(dub, entries=[]):
    text = ""
    dict_lines = dict() #para mantener el orden de entries
    
    for k in dub:
        #pos_parentesis = k.index("(")
        #clean_k = k[:pos_parentesis]
        #clean_k = quita_comillas(clean_k)
        symbol = "-"  
        if dub[k][0]:
            symbol = "+"
        dict_lines[entries.index(k)] = "{0} UB for {1} = {2}\n".format(symbol, k, dub[k][1])
        
    for k in dict_lines:
        text += dict_lines[k]
        
    return text    
 
    
def get_ub_original( program, entries ):
    command = COSTABS_BIN + ' ' + program + ' -entries '
    
    for e in entries:
        command += quita_comillas(e) + " "
        
    command += "-cost_model steps -field_abstraction zero_one"
    # print command
    output = check_output([command], stderr=FNULL, shell=True)
    #print output
    p = re.compile("UB for (.*?)\(.*\) = (.*)\n")
    ptime = re.compile("in (\d+) ms.")
    l = p.findall(output)
    ltimes = ptime.findall(output)
    total_time = sum(map(int,ltimes))
    
    d = dict()
    num_valid = 0
    for (a,b) in l:
        a = quita_comillas(a)
        if is_valid_ub(b):
            num_valid += 1
        d[a] = (is_valid_ub(b), b)
        
    return len(l), num_valid, total_time, d


def get_ub_rg(program, old_absc=False, entry="Main.main"):
    command = COSTABS_BIN + ' ' + program + ' -entries ' + entry + " -cost_model steps -rely_guarantee yes"
    if old_absc:
        command += " -absc_version 2013"
    output = check_output([command], stderr=FNULL, shell=True)
    p = re.compile("UB for (.*): (.*)\n")
    p2 = re.compile("(.+) (non-terminating)")
    ptime = re.compile("Rely-guarantee cost analysis in (\d+) ms.")
    l = p.findall(output)
    l += p2.findall(output)
    total_time = ptime.findall(output)[0]
    
    d = dict()
    num_valid = 0
    for (a,b) in l:
        if is_valid_ub(b):
            num_valid += 1
        d[a] = (is_valid_ub(b), b)
        
    return (len(l), num_valid, total_time, d)


    
      
    # ./costabs /home/kike/Systems/costa/costabs/examples/termination/improved/BoundedBuffer_annot.abs -entries 'BoundedBuffer.init' 'ProducerImpl.init' 'BoundedBuffer.append' -cost_model steps
    

def process_termination(programs):
    for (a,b) in programs:
        abs_program = b
        methods = get_method_names(abs_program)
        rg_term = get_termination_rg(abs_program)
        oc_term = get_termination_original(abs_program, methods)
        print "==============================================================="
        print a
        print "==============================================================="
        print "\nTermination RG\n--------------"
        print "Teminating Scopes: ", rg_term[1]
        print "Total Scopes     : ", rg_term[0]
        print "Time             : ", rg_term[2]  
        print rg_term[3]
        print "\n\nOriginal termination\n-----------------------------"
        print "Teminating Methods: ", oc_term[1]
        print "Total Methods     : ", oc_term[0]
        print "Time              : ", oc_term[2]
        print oc_term[3]
        
        
def process_cost(programs, old_absc=False, compare=False):
    for (a,b) in programs:
        abs_program = b
        methods = get_method_names(abs_program)
        rg_cost = get_ub_rg(abs_program, old_absc)
        oc_cost = get_ub_original(abs_program, methods)
        print rg_cost
        print oc_cost
        print "==============================================================="
        print a
        print "==============================================================="
        print "\nRELY GUARANTEE COST\n--------------"
        print "Valid UBs        : ", rg_cost[1]
        print "Total UBs        : ", rg_cost[0]
        print "Time             : ", rg_cost[2]  
        print pretty_dubs(rg_cost[3], methods)
        print "\n\nORIGINAL COST\n-----------------------------"
        print "Valid UBs         : ", oc_cost[1]
        print "Total UBs         : ", oc_cost[0]
        print "Time              : ", oc_cost[2]
        print pretty_dubs(oc_cost[3], methods)
        if compare:
            print "\n\nComparison\n~~~~~~~~~~~"
            show_comparison(rg_cost[3], oc_cost[3], methods)
        
        
def show_comparison(rg, oc, methods):
    n_const = 0
    n_comp = 0
    n_incomp = 0
    for m in methods:
        if rg[m][0] and oc[m][0]:
            command = "swipl -s ./ub_comparator.pl -t 'compare_ub_show( {0}, {1})'".format(rg[m][1], oc[m][1])
            output = check_output([command], stderr=FNULL, shell=True)
            if "constant" in output:
                n_const += 1
            elif "ratio" in output:
                n_comp += 1
            elif "incomparable" in output:
                n_incomp += 1
            else:
                raise NameError('Resultado de comparacion no esperado:' + output) 
            print m, ": ", output
            print "    RG: {0}".format(rg[m][1])
            print "    OC: {0}\n".format(oc[m][1])
            
    print "RESUMEN"
    print "#Constantes:", n_const
    print "#Comparables:", n_comp
    print "#Incomparables:", n_incomp            
        
    
    
if __name__ == "__main__":
    #Original programs (sin anotar)
    programs = []
    programs.append(('BOOKSHOP', '/home/kike/Systems/costa/costabs/examples/termination/improved/BookShop.abs'))
    programs.append(('BOUNDEDBUFFER', '/home/kike/Systems/costa/costabs/examples/termination/improved/BoundedBuffer.abs'))
    programs.append(('CHAT', '/home/kike/Systems/costa/costabs/examples/termination/improved/Chat.abs'))
    programs.append(('DISTHT', '/home/kike/Systems/costa/costabs/examples/termination/improved/DistHT.abs'))
    programs.append(('MAILSERVER', '/home/kike/Systems/costa/costabs/examples/termination/improved/MailServer.abs'))
    programs.append(('PEERTOPEER', '/home/kike/Systems/costa/costabs/examples/termination/improved/PeerToPeer.abs'))
    programs.append(('FACT', '/home/kike/Systems/costa/costabs/examples/termination/improved/Fact.abs'))
    programs.append(('COSTLY FACT', '/home/kike/Systems/costa/costabs/examples/termination/improved/Costly_Fact.abs'))
    programs.append(('DB PROTOCOL', '/home/kike/Systems/costa/costabs/examples/termination/improved/DB_protocol.abs'))
    ######programs.append(('WATER MAKING', '/home/kike/Systems/costa/costabs/examples/termination/improved/Water_Making.abs'))
    programs.append(('SLEEPING BARBER', '/home/kike/Systems/costa/costabs/examples/termination/improved/Sleeping_Barber.abs'))
    ######programs.append(('HUNGRY BIRDS', '/home/kike/Systems/costa/costabs/examples/termination/improved/Hungry_Birds.abs'))
    programs.append(('PAIRING PROBLEM', '/home/kike/Systems/costa/costabs/examples/termination/improved/Pairing_Problem.abs'))
    ######programs.append(('PIPE SORT', '/home/kike/Systems/costa/costabs/examples/termination/improved/PipeSort.abs'))
    ######programs.append(('PI', '/home/kike/Systems/costa/costabs/examples/termination/improved/Pi.abs'))
    programs.append(('RUNNING1', '/home/kike/Systems/costa/costabs/examples/termination/improved/Running1.abs'))
    programs.append(('RUNNING2', '/home/kike/Systems/costa/costabs/examples/termination/improved/Running2.abs'))
    programs.append(('RUNNING3', '/home/kike/Systems/costa/costabs/examples/termination/improved/Running3.abs'))
    programs.append(('INTERLEAVINGS', '/home/kike/Systems/costa/costabs/examples/termination/improved/Interleavings.abs'))

    
    #Annotated programs
    programs_annot = []
    programs_annot.append(('BOOKSHOP ANNOT', '/home/kike/Systems/costa/costabs/examples/termination/improved/BookShop_annot.abs'))
    programs_annot.append(('BOUNDEDBUFFER ANNOT', '/home/kike/Systems/costa/costabs/examples/termination/improved/BoundedBuffer_annot.abs'))
    programs_annot.append(('CHAT ANNOT', '/home/kike/Systems/costa/costabs/examples/termination/improved/Chat_annot.abs'))
    programs_annot.append(('DISTHT ANNOT', '/home/kike/Systems/costa/costabs/examples/termination/improved/DistHT_annot.abs'))
    programs_annot.append(('MAILSERVER ANNOT', '/home/kike/Systems/costa/costabs/examples/termination/improved/MailServer_annot.abs'))
    # Caso especial por usar el absc_version 2013
    programs_annot.append(('PEERTOPEER ANNOT', '/home/kike/Systems/costa/costabs/examples/termination/improved/PeerToPeer_annot.abs'))
    programs_annot.append(('FACT', '/home/kike/Systems/costa/costabs/examples/termination/improved/Fact.abs'))
    programs_annot.append(('COSTLY FACT', '/home/kike/Systems/costa/costabs/examples/termination/improved/Costly_Fact.abs'))
    programs_annot.append(('DB PROTOCOL', '/home/kike/Systems/costa/costabs/examples/termination/improved/DB_protocol.abs'))
    ######programs.append(('WATER MAKING', '/home/kike/Systems/costa/costabs/examples/termination/improved/Water_Making.abs'))
    programs_annot.append(('SLEEPING BARBER', '/home/kike/Systems/costa/costabs/examples/termination/improved/Sleeping_Barber.abs'))
    ######programs.append(('HUNGRY BIRDS', '/home/kike/Systems/costa/costabs/examples/termination/improved/Hungry_Birds.abs'))
    programs_annot.append(('PAIRING PROBLEM', '/home/kike/Systems/costa/costabs/examples/termination/improved/Pairing_Problem.abs'))
    ######programs.append(('PIPE SORT', '/home/kike/Systems/costa/costabs/examples/termination/improved/PipeSort.abs'))
    ######programs.append(('PI', '/home/kike/Systems/costa/costabs/examples/termination/improved/Pi.abs'))
    programs_annot.append(('RUNNING1 ANNOT', '/home/kike/Systems/costa/costabs/examples/termination/improved/Running1_annot.abs'))
    programs_annot.append(('RUNNING2 ANNOT', '/home/kike/Systems/costa/costabs/examples/termination/improved/Running2_annot.abs'))
    programs_annot.append(('RUNNING3 ANNOT', '/home/kike/Systems/costa/costabs/examples/termination/improved/Running3_annot.abs'))
    programs_annot.append(('INTERLEAVINGS ANNOT', '/home/kike/Systems/costa/costabs/examples/termination/improved/Interleavings_annot.abs'))

    
    # Para calcular la terminacion
    #process_termination(programs)
        
    # Para calcular el coste
    process_cost(programs,old_absc=False,compare=True)

    
    # Para calcular el coste y comparar con progs anotados
    # process_cost(programs_annot,old_absc=False,compare=True)
    
