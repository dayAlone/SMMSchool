Package.describe({
  summary: "A Meteor 0.9 package for moment.js including support for locales (moment v2.8.3)",
  version: "0.0.3",
  git: "https://github.com/FLamparski/meteor-moment-locales"
});

var core = [
  'bower_components/moment/moment.js'
];

var locales = [
  'bower_components/moment/locale/ru.js'
];

var exporter = [
  'flamparski:moment-locales.js'
];

Package.onUse(function(api) {
  api.versionsFrom('METEOR@0.9.0');
  var files = core.concat(locales).concat(exporter);
  api.addFiles(files, ['client', 'server']);
  api.export(['moment'], ['client', 'server']);
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('flamparski:moment-locales');
  api.addFiles('flamparski:moment-locales-tests.js');
});
