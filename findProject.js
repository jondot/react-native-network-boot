// based on findProject from rnpm
var glob = require('glob'),
    path = require('path')

var GLOB_PATTERN = '**/*.xcodeproj/project.pbxproj'
var TEST_PROJECTS = /test|example|sample/i
var IOS_BASE = 'ios'
var GLOB_EXCLUDE_PATTERN = ['**/@(Pods|node_modules)/**']

module.exports = function findProject(folder) {
  var projects = glob
    .sync(GLOB_PATTERN, {
      cwd: folder,
      ignore: GLOB_EXCLUDE_PATTERN,
    })
    .filter(function(project){
      return path.dirname(project) === IOS_BASE || !TEST_PROJECTS.test(project)
    });

  if (projects.length === 0) {
    return null;
  }

  return projects[0]
};
