module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    clean: [
      '<%= config.input %>.js'
    ]
    # es6-module-transpiler
    transpile:
      main:
        files:
          expand: true
          src: ['**/*.js']
          dest: 'dist/'
        # or "amd" or "yui"
        type: "cjs"
    shell:
      runcoffee:
        command: 'coffee <%= config.input %>.coffee'
      runjs:
        command: 'node <%= config.input %>.js'
    watch:
      files: ['<%= config.input %>.coffee']
      tasks: ['coffee']
      options: { nospawn: true }
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-es6-module-transpiler'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-shell'
  grunt.registerTask 'default', ['transpile', 'shell']
