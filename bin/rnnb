#!/usr/bin/env node
//use this instead? https://github.com/flatiron/prompt

if(process.argv.length == 3 && process.argv[2] == 'ios'){
  var xcode = require('xcode'),
      fs = require('fs'),
      inquirer = require('inquirer'),
      findProject = require('../findProject')

  var question =
    {
      type: 'input',
      name: 'pbxproj',
      message: 'Your project.pbxproj location so I can add a Run Script phase?',
      default: '',
      validate: function (value) {
        if (value) {
          return true;
        }

        return 'Please your main project.pbxproj location';
      }
    }
  question.default = findProject(process.cwd())

  var comment = 'react native boot run script phase'
  var script = "../node_modules/react-native-network-boot/boot.sh"

  inquirer.prompt([ question ]).then(function (answers) {
    var projectPath = answers['pbxproj']
    myProj = xcode.project(projectPath)
    myProj.parse(function (err) {
      var item = myProj.pbxItemByComment(comment, 'PBXShellScriptBuildPhase')
      if(item){
        console.log("Already initialized.")
      }else{
        myProj.addBuildPhase([], 'PBXShellScriptBuildPhase', comment, null, null, null, script)
        fs.writeFileSync(projectPath, myProj.writeSync());
        console.log('Initialized in ' + projectPath);
      }
    });
  })
}else{
   console.log("Currently only 'rnnb ios' is supported.")
}
