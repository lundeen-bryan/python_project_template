"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Project = void 0;
const vscode = require("vscode");
const path = require("path");
const UI_1 = require("./UI");
const fs = require("fs");
class Project {
    constructor(context) {
        this.dirc = new Array('docs', 'data', 'src', 'logs', 'test', 'examples', '.vscode');
        this.context = context;
    }
    async createFiles({ location }) {
        try {
            const mainPath = path.join(this.context.extensionPath, 'templates', 'main.py');
            const reqPath = path.join(this.context.extensionPath, 'templates', 'requirements.txt');
            const runPath = path.join(this.context.extensionPath, 'templates', 'run.bat');
            const readPath = path.join(this.context.extensionPath, 'templates', 'README.md');
            const gitPath = path.join(this.context.extensionPath, 'templates', '.gitignore');
            const changelogPath = path.join(this.context.extensionPath, 'templates', 'CHANGELOG.md');
            const configPath = path.join(this.context.extensionPath, 'templates', 'config.json');
            fs.writeFileSync(path.join(location, 'src', 'main.py'), fs.readFileSync(mainPath, "utf-8"));
            fs.writeFileSync(path.join(location, 'requirements.txt'), fs.readFileSync(reqPath, "utf-8"));
            fs.writeFileSync(path.join(location, "run.bat"), fs.readFileSync(runPath, "utf-8"));
            fs.writeFileSync(path.join(location, "README.md"), fs.readFileSync(readPath, "utf-8"));
            fs.writeFileSync(path.join(location, ".gitignore"), fs.readFileSync(gitPath, "utf-8"));
            fs.writeFileSync(path.join(location, "CHANGELOG.md"), fs.readFileSync(changelogPath, "utf-8"));
            fs.writeFileSync(path.join(location, "config.json"), fs.readFileSync(configPath, "utf-8"));
            vscode.workspace.openTextDocument(path.join(location, 'src', 'main.py')).then(doc => vscode.window.showTextDocument(doc, { preview: false }));
        }
        catch (err) {
            console.error(err);
        }
    }
    async createFolders(location) {
        const dirSubdirPairs = [
            { dir: 'docs', subdirs: ['research', 'tutorials'] },
            { dir: 'data', subdirs: ['excel', 'pdf', 'jupyter', 'sql'] },
            { dir: 'src' },
            { dir: 'logs' },
            { dir: 'test' },
            { dir: 'examples' },
            { dir: '.vscode' },
            // add more directory and subfolder pairs here as needed
        ];

        for (let pair of dirSubdirPairs) {
            const { dir, subdirs } = pair;
            try {
                fs.mkdirSync(path.join(location, dir));
                if (subdirs) {
                    for (let subdir of subdirs) {
                        fs.mkdirSync(path.join(location, dir, subdir));
                    }
                }
            }
            catch (err) {
                console.error(err);
            }
        }
    }
    async createProject() {
        const result = await UI_1.UI.openDialogForFolder();
        if (result && result.fsPath) {
            await vscode.commands.executeCommand('vscode.openFolder', result);
            await this.createFolders(result.fsPath);
            await this.createFiles({ location: result.fsPath });
        }
    }
}
exports.Project = Project;
//# sourceMappingURL=project.js.map