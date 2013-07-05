gulp = require '../'
should = require 'should'
require 'mocha'

{join} = require 'path'

describe 'gulp single file collection', ->
  describe 'file()', ->
    it 'should return a stream', (done) ->
      stream = gulp.file join __dirname, "./fixtures/test.coffee"
      should.exist stream
      should.exist stream.on # good enough for me
      done()

    it 'should return a file stream from a flat path', (done) ->
      stream = gulp.files join __dirname, "./fixtures/test.coffee"

      stream.on 'error', (err) -> throw err
      stream.on 'data', (file) ->
        should.exist file
        should.exist file.path
        should.exist file.contents

        file.path.should.equal join __dirname, "./fixtures/test.coffee"
        String(file.contents).should.equal "this is a test"

      stream.on 'end', -> done()