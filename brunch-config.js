// See http://brunch.io for documentation.
exports.files = {
  javascripts: {
    joinTo: {
      'vendor.js': /^(?!app)/, // Files that are not in `app` dir.
      'app.js': /^app/
    }
  },
  stylesheets: {joinTo: 'app.css'}
};

exports.plugins = {
  babel: {presets: ['latest']},
  sass: {mode: 'native'},
  elmBrunch: {
    mainModules: ["app/elm/app/Main.elm"],
    makeParameters : ['--warn'],
    outputFolder: "public/js/"
  }
};
