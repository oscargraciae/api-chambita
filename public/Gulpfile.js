/*
  ServiceBox, SEBOX

  trabajo
  provedor
  servicio

*/

// Green #3CBC8D
// Blue #1C94C6

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
  gulp.src('stylus/**/*.styl')
  .pipe(stylus({compress:true}))
  .pipe(concat('style.css'))
  .pipe(gulp.dest('./css'))
});


gulp.task('watch', function() {
  gulp.watch('stylus/**/*.styl', ['css'])
});
