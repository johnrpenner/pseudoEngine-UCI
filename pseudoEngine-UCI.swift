// pseudoEngine UCI v0.1 ©johnRolandPenner (June 21, 2024)
// Minimal UCI Asynchronous Timed Engine in Swift
// 
//  This Swift Template seeks to address four issues related to UCI implemenation: 
//  1) UCI Responds to Terminal Commands using: readLine() and print()
//  2) Asynchronous Multi-Threading to allow UCI to respond while Engine Processes
//  3) Adding Timer Abort — sending a signal into the Engine to Abort on a Timer
//  4) HiArcs Chess says: Not a Valid Engine > import os and fflush(__stdoutp) after print()

import Foundation
import os			// necessary for fflush(__stdoutp)

class pseudoEngine {
	
	private var predefinedMoves : [String] = ["e7e5", "d7d5", "g8f6", "c7c5", "b8c6", "a7a6", "h7h6"]
	private var currentMoveIndex = 0
	
	// Asynchronous Queue to Handle UCI Commands
	private let queue = DispatchQueue(label: "peaBrain.queue", attributes: .concurrent)
	
	// Timer Termination Flag
	private var shouldTerminate = false 
	
	
	func run() {
		
		// Start Background Thread for Processing Commands
		queue.async { [weak self] in
			while let line = readLine() {
				self?.handleCommand(line)
        	}
    	}
		
    	// Keep main thread alive to listen for commands
    	RunLoop.main.run()
	}


    private func handleCommand(_ command: String) {
        let trimmedCommand = command.trimmingCharacters(in: .whitespacesAndNewlines)
		let firstWord = trimmedCommand.split(separator:  " ").first!
		
		switch firstWord {
			
			// uci → uciok
			case "uci" : 
				sendUCIResponse()
			
			// isready → readyok
			case "isready" : 
				print("readyok")
				fflush(__stdoutp)
			
			//case "ucinewgame" :  
				currentMoveIndex = 0
			
			// position startpos moves e2e4
			//case "position" :  
				//let moveWords = trimmedCommand.split(separator: " ").dropFirst(3)
				//currentMoveIndex = (movesWords.count + 1) / 2
			
			// go wtime 4000 btime 4000 movestogo 9
			case "go" : 
				shouldTerminate = false
				startTimer()
				processMove()
				
			case "quit" : 
				exit(0)

			default: 
				// deal with default response here.. 🤷🏼‍♂️ 
				fflush(__stdoutp)
				
			}
		}
	
	
	private func sendUCIResponse() {
		print("id name pseudoEngine 0.1")
		print("author johnRolandPenner")
		print("option name UCI_EngineAbout type string default pseudoEngine 0.1 by rdp")
		print("uciok")
		fflush(__stdoutp)
	}
	
	
	// Process Move Asynchronously + Timer
	private func processMove() {
		queue.async { [weak self] in 
			guard let self = self else { return }
			
			while !self.shouldTerminate {
				
				guard self.currentMoveIndex < 7 else {
					print("bestmove 0000")
					fflush(__stdoutp)
					return
					}
				
					// Simulate Processing NegaSearch() for 1 second
					print("info depth \(currentMoveIndex) score cp -2 time 10 nodes 26 nps 777 pv e7e6")
					fflush(__stdoutp)
					sleep(1)
					let bestMove = self.predefinedMoves[self.currentMoveIndex]
					print("bestmove \(bestMove)")
					fflush(__stdoutp)
					self.currentMoveIndex += 1
					break
					}
			
			// quit asynchronous quoue
			}
			
		// end processMove()
		}

	
	// Setup 5 second Timer to Simulate NegaSearch()
	private func startTimer() {
		let timer = DispatchSource.makeTimerSource(queue: queue)
		timer.schedule(deadline: .now() + 5.0)
		timer.setEventHandler { [weak self] in 
			self?.shouldTerminate = true
			}
		timer.activate()
	}
	
}


let engine = pseudoEngine()
engine.run()
