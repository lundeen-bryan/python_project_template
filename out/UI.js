"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.UI = void 0;
const vscode_1 = require("vscode");
class UI {
    static async openDialogForFolder() {
        const options = {
            canSelectFiles: false,
            canSelectFolders: true,
            canSelectMany: false
        };
        const result = await vscode_1.window.showOpenDialog(Object.assign(options));
        if (result && result.length) {
            return Promise.resolve(result[0]);
        }
        else {
            return Promise.reject();
        }
    }
}
exports.UI = UI;
//# sourceMappingURL=UI.js.map