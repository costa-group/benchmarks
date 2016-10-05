rm -f Results/*

#Whole case studies
time(/home/aeflores/Systems/costa/costabs/src/interfaces/deadlock/shell/deadlock_shell  -i "/home/aeflores/Systems/costa/costabs/examples/deadlock/products/AUTO_TwoClients.abs"  >"./Results/AUTO_TwoClients.abs.mhp.out")


time(/home/aeflores/Systems/costa/costabs/src/interfaces/deadlock/shell/deadlock_shell  -i "/home/aeflores/Systems/costa/costabs/examples/deadlock/products/AUTO_tradingSystem.abs"  >"./Results/AUTO_tradingSystem.abs.mhp.out")

#adapted RS

time(/home/aeflores/Systems/costa/costabs/src/interfaces/deadlock/shell/deadlock_shell  -i "/home/aeflores/Systems/costa/costabs/examples/deadlock/products/Fakerep.abs"  >"./Results/Fakerep.abs.mhp.out")

time(/home/aeflores/Desktop/SDAtool/bin/bash/parseABS  "/home/aeflores/Systems/costa/costabs/examples/deadlock/Fakerep.abs"  >"./Results/Fakerep.abs.contracts.out")

#bounded buffer

time(/home/aeflores/Systems/costa/costabs/src/interfaces/deadlock/shell/deadlock_shell  -i  "/home/aeflores/Desktop/SDAtool/examples/BoundedBuffer.abs"  >"./Results/BoundedBuffer.abs.mhp.out")

time(/home/aeflores/Desktop/SDAtool/bin/bash/parseABS  "/home/aeflores/Desktop/SDAtool/examples/BoundedBuffer.abs"  >"./Results/BoundedBuffer.abs.contracts.out")

#pingpong

time(/home/aeflores/Systems/costa/costabs/src/interfaces/deadlock/shell/deadlock_shell  -i  "/home/aeflores/Desktop/SDAtool/examples/PingPong.abs"  >"./Results/PingPong.abs.mhp.out")

#peertopeer

time(/home/aeflores/Systems/costa/costabs/src/interfaces/deadlock/shell/deadlock_shell  -i  "/home/aeflores/Desktop/SDAtool/examples/PeerToPeer.abs"  >"./Results/PeerToPeer.abs.mhp.out")

#leaderelection

time(/home/aeflores/Systems/costa/costabs/src/interfaces/deadlock/shell/deadlock_shell  -i  "/home/aeflores/Desktop/SDAtool/examples/LeaderElection.abs"  >"./Results/LeaderElection.abs.mhp.out")

#bookshop

time(/home/aeflores/Systems/costa/costabs/src/interfaces/deadlock/shell/deadlock_shell  -i  "/home/aeflores/Desktop/SDAtool/examples/BookShop.abs"  >"./Results/BookShop.abs.mhp.out")

#multipingpong

time(/home/aeflores/Systems/costa/costabs/src/interfaces/deadlock/shell/deadlock_shell  -i  "/home/aeflores/Desktop/SDAtool/examples/MultiPingPong.abs"  >"./Results/MultiPingPong.abs.mhp.out")


