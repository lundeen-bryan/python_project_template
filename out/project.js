"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Project = void 0;
const vscode = require("vscode");
const path = require("path");
const UI_1 = require("./UI");
const fs = require("fs");
class Project {
    constructor(context) {
        this.dirc = new Array('src', 'imports', 'test', '.vscode');
        this.context = context;
    }
    async createFiles({ location }) {
        try {
            const reqPath = path.join(this.context.extensionPath, 'templates', 'requirements.txt');
            const runPath = path.join(this.context.extensionPath, 'templates', 'create_venv.sh');
            const readPath = path.join(this.context.extensionPath, 'templates', 'README.md');
            const gitPath = path.join(this.context.extensionPath, 'templates', '.gitignore');
            const changelogPath = path.join(this.context.extensionPath, 'templates', 'CHANGELOG.md');
            const configPath = path.join(this.context.extensionPath, 'templates', 'config.json');
            const importPath = path.join(this.context.extensionPath, 'templates', '_clear_console.py');
            const initPath = path.join(this.context.extensionPath, 'templates', '__init__.py');
            const setupPath = path.join(this.context.extensionPath, 'templates', 'setup.py');
            const snippetPath = path.join(this.context.extensionPath, 'templates', 'python.code-snippets');
            const scriptPath = path.join(this.context.extensionPath, 'templates', 'list_scripts.py');
            fs.writeFileSync(path.join(location, 'requirements.txt'), fs.readFileSync(reqPath, "utf-8"));
            fs.writeFileSync(path.join(location, "create_venv.sh"), fs.readFileSync(runPath, "utf-8"));
            fs.writeFileSync(path.join(location, "README.md"), fs.readFileSync(readPath, "utf-8"));
            fs.writeFileSync(path.join(location, ".gitignore"), fs.readFileSync(gitPath, "utf-8"));
            fs.writeFileSync(path.join(location, "CHANGELOG.md"), fs.readFileSync(changelogPath, "utf-8"));
            fs.writeFileSync(path.join(location, 'imports', 'config.json'), fs.readFileSync(configPath, "utf-8"));
            fs.writeFileSync(path.join(location, 'imports', 'list_scripts.py'), fs.readFileSync(scriptPath, "utf-8"));
            fs.writeFileSync(path.join(location, '.vscode', 'python.code-snippets'), fs.readFileSync(snippetPath, "utf-8"));
            fs.writeFileSync(path.join(location, 'imports', '_clear_console.py'), fs.readFileSync(importPath, "utf-8"));
            fs.writeFileSync(path.join(location, 'imports', '__init__.py'), fs.readFileSync(initPath, "utf-8"));
            fs.writeFileSync(path.join(location, 'setup.py'), fs.readFileSync(setupPath, "utf-8"));
            vscode.workspace.openTextDocument(path.join(location, 'setup.py')).then(doc => vscode.window.showTextDocument(doc, { preview: false }));
        }
        catch (err) {
            console.error(err);
        }
    }
    async createFolders(location) {
        const dirSubdirPairs = [
            { dir: 'src', subdirs: ['jupyter', 'python'] },
            { dir: 'imports' },
            { dir: 'test' },
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