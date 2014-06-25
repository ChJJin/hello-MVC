var gulp = require('gulp'),
    gutil = require('gulp-util'),
    coffee = require('gulp-coffee'),
    concat = require('gulp-concat'),
    header = require('gulp-header'),
    footer = require('gulp-footer');

var config = {
  src: ['./src/event.coffee', './src/!(event.coffee|index.coffee)', './src/index.coffee'],
  dest: './lib/',
  destFile: 'MVC.js',
  header: ['(function(exports){', '\r\n'],
  footer: ['', '})(exports);']
};

gulp.task('script', function(){
  gulp.src(config.src)
    .pipe(concat(config.destFile, {newLine: "\r\n"}))
    .pipe(coffee({bare: true}).on('error', gutil.log))
    .pipe(header(config.header.join('\r\n')))
    .pipe(footer(config.footer.join('\r\n')))
    .pipe(gulp.dest(config.dest));
});

gulp.task('default', ['script']);
