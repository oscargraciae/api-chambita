/*
* Dependencias
*/
var gulp = require('gulp'),
  concat = require('gulp-concat'),
  uglify = require('gulp-uglify');

var stylus = require('gulp-stylus');

/*
* Configuración de la tarea 'demo'
*/
gulp.task('demo', function () {
  gulp.src('js/source/*.js')
  .pipe(concat('todo.js'))
  .pipe(uglify())
  .pipe(gulp.dest('js/build/'))
});


gulp.task('css', function(){
  gulp.src('styles/*.styl')
  .pipe(stylus({compress:true}))
  .pipe(concat('todo.css'))
  .pipe(gulp.dest('styles/css/'))
});
