import netP5.NetAddress;
import oscP5.OscP5;
import oscP5.OscMessage;

class WekControl {
  OscP5 oscP5;
  NetAddress dest;
  final boolean debugPrint;

  public WekControl(OscP5 oscP5, NetAddress dest) {
    // Kalder nedenstående constructor
    this(oscP5, dest, false);
  }
  public WekControl(OscP5 oscP5, NetAddress dest, boolean debugPrint) {
    this.oscP5 = oscP5;
    this.dest = dest;
    this.debugPrint = debugPrint;
  }

  private OscMessage ctrlMsg(String name) {
    return new OscMessage("/wekinator/control/" + name);
  }

  public void outputs(float... outputValues) {
    OscMessage msg = ctrlMsg("outputs");
    if (debugPrint) {
      println("Set outputs to " + outputValues);
    }
    msg.add(outputValues);  
    oscP5.send(msg, dest);
  }

  public void startRecording() {
    if (debugPrint) {
      println("Started Recording");
    }
    oscP5.send(ctrlMsg("startRecording"), dest);
  }

  public void stopRecording() {
    if (debugPrint) {
      println("Stopped Recording");
    }
    oscP5.send(ctrlMsg("stopRecording"), dest);
  }
  public void startDtwRecording() {     
    if (debugPrint) {       
      println("Started DTW Recording");
    }     
    oscP5.send(ctrlMsg("startDtwRecording"), dest);
  }
  public void stopDtwRecording() {     
    if (debugPrint) {       
      println("Stopped DTW Recording");
    }     
    oscP5.send(ctrlMsg("stopDtwRecording"), dest);
  }
  public void train() {     
    if (debugPrint) {       
      println("Training");
    }     
    oscP5.send(ctrlMsg("train"), dest);
  }
  public void cancelTrain() {     
    if (debugPrint) {       
      println("Cancelled training");
    }     
    oscP5.send(ctrlMsg("cancelTrain"), dest);
  }
  public void startRunning() {     
    if (debugPrint) {       
      println("Started running");
    }     
    oscP5.send(ctrlMsg("startRunning"), dest);
  }
  public void stopRunning() {     
    if (debugPrint) {       
      println("Stopped running");
    }     
    oscP5.send(ctrlMsg("stopRunning"), dest);
  }
  // Deletes all examples for all models
  public void deleteAllExamples() {     
    if (debugPrint) {       
      println("Deleted all examples");
    }     
    oscP5.send(ctrlMsg("deleteAllExamples"), dest);
  }
  // Deletes examples for a specified output
  // Output indices start at 1
  public void deleteExamplesForOutput(int... outputs) { 
    OscMessage msg = ctrlMsg("deleteExamplesForOutput");
    msg.add(outputs);
    if (debugPrint) {       
      println("Deleted all examples for outputs " + outputs);
    }
    oscP5.send(msg, dest);
  }
  public void enableModelRunning(int... models) {     
    OscMessage msg = ctrlMsg("enableModelRunning");
    if (debugPrint) {
      println("Enabled models " + models + " running");
    }
    msg.add(models);  
    oscP5.send(msg, dest);
  }
  public void disableModelRunning(int... models) {     
    OscMessage msg = ctrlMsg("disableModelRunning");
    if (debugPrint) {
      println("Disabled models " + models + " running");
    }
    msg.add(models);  
    oscP5.send(msg, dest);
  }
  // Only works when Wekinator is on the setup screen
  public void setInputNames(String... names) {     
    OscMessage msg = ctrlMsg("setInputNames");
    if (debugPrint) {       
      println("Set input names as " + names);
    }
    msg.add(names);
    oscP5.send(msg, dest);
  }
  // Only works when Wekinator is on the setup screen
  public void setOutputNames(String... names) {     
    OscMessage msg = ctrlMsg("setOutputNames");
    if (debugPrint) {       
      println("Set output names as " + names);
    }
    msg.add(names);
    oscP5.send(msg, dest);
  }
  public void selectInputsForOutput(int output, int... connectedInputs) {
    OscMessage msg = ctrlMsg("selectInputsForOutput");
    if (debugPrint) {       
      println("Seleceted " + connectedInputs + " as inputs for output " + output);
    }
    msg.add(output);
    msg.add(connectedInputs);
    oscP5.send(msg, dest);
  }
}
