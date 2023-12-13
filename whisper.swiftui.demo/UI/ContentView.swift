import SwiftUI
import AVFoundation

struct ContentView: View {
    @StateObject var whisperState = WhisperState()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button(whisperState.isRecording ? "Stop recording" : "Start recording", action: {
                        Task {
                            await whisperState.toggleRecord()
                        }
                    })
                    .buttonStyle(.bordered)
                    .disabled(!whisperState.canTranscribe)
                }
				.padding(.bottom, 30)

				Text("Select Whisper Model")
					.font(.headline)
				Text("Current: \(whisperState.currentModelName)")
					.font(.caption)

				ForEach(ModelType.allCases, id: \.self) { model in
					Button(model.rawValue) {
						whisperState.switchModel(type: model)
					}
					.padding(.vertical, 10)
				}

                ScrollView {
                    Text(verbatim: whisperState.messageLog)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .navigationTitle("Whisper Demo")
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
