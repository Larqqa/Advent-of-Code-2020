const browserSync = require('browser-sync').create();
const gulp        = require('gulp');

// Reload webpage when PHP files change
function defaultTask() {
  browserSync.init({
    files: ['**/*.php'],
    proxy: 'localhost',
  });
}
gulp.task('default', defaultTask);