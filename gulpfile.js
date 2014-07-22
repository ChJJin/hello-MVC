var gulp = require('gulp'),
    g    = require('gulp-load-plugins')();

var config = {
  src: ['./src/event.coffee', './src/!(event.coffee|index.coffee)', './src/index.coffee'],
  dest: './lib/',
  destFile: 'MVC.js'
};

gulp.task('script', function(){
  gulp.src(config.src)
    .pipe(g.concat(config.destFile, {newLine: "\r\n"}))
    .pipe(g.coffee({bare: true}).on('error', g.util.log))
    .pipe(g.wrap([';(function(exports){',
      '<%= contents %>',
      '})(exports);'].join('\r\n')))
    .pipe(gulp.dest(config.dest));
});

gulp.task('default', ['script']);
