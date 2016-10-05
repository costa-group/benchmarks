from subprocess import check_output

def main():
    programs = ["BookShop.abs", "BoundedBuffer.abs", "Chat.abs", "DistHT.abs", "MailServer.abs", "PeerToPeer.abs", "NewMod_replicationSystem.abs", "Fact.abs", "Costly_Fact.abs", "DB_protocol.abs", "Sleeping_Barber.abs", "Pairing_Problem.abs", "Running1.abs", "Running2.abs", "Running3.abs", "Interleavings.abs"]
    
    prog_str = " ".join(programs)
    command = 'cloc --force-lang="Java",abs --by-file {0}'.format(prog_str)
    output = check_output([command], shell=True)
    lines = output.split("\n")
    d = dict()
    
    for line in lines:
        l = line.split()
        if len(l) == 4 and l[0] in programs:
            d[ l[0] ] = {'blank':l[1], 'comment':l[2], 'code':l[3]}

    print "{5:<3} {0:30} {1:>8} {2:>8} {3:>8} {4:>8}".format("Program","LOC", "blank", "comment", "total", "") 
    print 
    i = 1
    for p in programs:
        print "{5:<3} {0:30} {1:>8} {2:>8} {3:>8} {4:>8}".format(p, d[p]['code'], d[p]['blank'], d[p]['comment'], int(d[p]['code']) + int(d[p]['blank']) + int(d[p]['comment']), i)
        i += 1
        

if __name__ == "__main__":
    main()
