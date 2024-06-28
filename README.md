pseudoEngine UCI v0.1 ©johnRolandPenner (June 21, 2024)
Minimal UCI Asynchronous Timed Engine in Swift
 
This Swift Template seeks to address four issues related to UCI implemenation: 
1) UCI Responds to Terminal Commands using: readLine() and print()
2) Asynchronous Multi-Threading to allow UCI to respond while Engine Processes
3) Adding Timer Abort — sending a signal into the Engine to Abort on a Timer
4) HiArcs Chess says: Not a Valid Engine > import os and fflush(__stdoutp) after print()

% swiftc -o pseudoEngine pseudoEngine-UCI.swift
% ./pseudoEngine
uci
id name pseudoEngine 0.1
author johnRolandPenner
option name UCI_EngineAbout type string default pseudoEngine 0.1 by rdp
uciok
isready
readyok
go
info depth 0 score cp -2 time 10 nodes 26 nps 777 pv e7e6
bestmove e7e5
go
info depth 1 score cp -2 time 10 nodes 26 nps 777 pv e7e6
bestmove d7d5
go
info depth 2 score cp -2 time 10 nodes 26 nps 777 pv e7e6
quit
% 
