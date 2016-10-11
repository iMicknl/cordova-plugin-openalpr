@objc(OpenALPR) class OpenALPR : CDVPlugin {

   func scan(_ command: CDVInvokedUrlCommand) {

    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

    let msg = "Called native Swift code! <3"
    let filepath = command.arguments[0] as? String ?? ""
    print("Scan for file: " + filepath);

    if msg.characters.count > 0 {
      /* UIAlertController is iOS 8 or newer only. */
      let toastController: UIAlertController =
        UIAlertController(
          title: "",
          message: msg,
          preferredStyle: .alert
        )

      self.viewController?.present(
        toastController,
        animated: true,
        completion: nil
      )

      let duration = Double(NSEC_PER_SEC) * 3.0

      DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(duration)) / Double(NSEC_PER_SEC),
        execute: {
          toastController.dismiss(
            animated: true,
            completion: nil
          )
        }
      )

      pluginResult = CDVPluginResult(
        status: CDVCommandStatus_OK,
        messageAs: msg
      )
    }

    self.commandDelegate!.send(
      pluginResult,
      callbackId: command.callbackId
    )
  }
}
