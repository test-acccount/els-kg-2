import { DirectUpload } from 'activestorage'
import Uppy from '@uppy/core'
import Dashboard from '@uppy/dashboard'
import { Plugin } from '@uppy/core'
const Russian = require('@uppy/locales/lib/ru_RU')

// ActiveStorage DirectUpload
class Uploader {
  constructor(file_data, url, input, uppy, fileID) {
    this.upload = new DirectUpload(file_data, url, this)
    this.input  = input
    this.uppy   = uppy
    this.fileID = fileID
  }

  startUpload() {
    this.upload.create((error, blob) => {
      if (error) {
        this.uppy.uppy.emit('upload-error', this.fileID, error)
      } else {
        // Add an appropriately-named hidden input to the form
        // with a value of blob.signed_id
        const hiddenField = document.createElement('input')
        hiddenField.setAttribute('type', 'hidden');
        hiddenField.setAttribute('value', blob.signed_id);
        hiddenField.name = this.input.name
        document.querySelector('form').appendChild(hiddenField)

        this.uppy.uppy.setFileState(this.fileID.id, { status: 'success' })
        this.uppy.uppy.emit('upload-success', this.fileID, 'success')

        return new Promise((resolve) => { resolve(this.fileID) })
      }
    })
  }

  directUploadWillStoreFileWithXHR(request) {
    request.upload.addEventListener('progress', event => this.directUploadDidProgress(event))
  }

  directUploadDidProgress(event) {
    // Use event.loaded and event.total to update the progress bar
    this.uppy.uppy.emit('upload-progress', this.fileID, {
      uploader: this.uppy.uppy.uploaders[0],
      bytesUploaded: event.loaded,
      bytesTotal: event.total
    })
  }
}

// Uppy custom uploader
class ASUploader extends Plugin {
  constructor (uppy, opts) {
    super(uppy, opts)
    this.uppy = uppy
    this.id = 'ASUploader'
    this.type = 'uploader'
    this.upload = this.upload.bind(this)
    this.input = opts.input
    this.url = this.input.dataset.directUploadUrl
  }

  upload (fileIDs) {
    let promises = []
    for (let fileID of fileIDs) {
      let uppy_file = this.uppy.getFile(fileID)

      this.uppy.emit('upload-started', uppy_file)

      let uploader = new Uploader(uppy_file.data, this.url, this.input, this, uppy_file)
      promises.push(uploader.startUpload())
    }

    return Promise.all(promises)
  }

  install() {
    this.uppy.addUploader(this.upload)
  }

  uninstall() {
    this.uppy.removeUploader(this.upload)
  }
}

// Set Uppy on pages where <div id="uppy"></div> is present
document.addEventListener('turbolinks:load', function() {
  const uppy_target = document.querySelector('#uppy')
  if (uppy_target) {
    const input = document.querySelector('input[type=file]')
    const url = input.dataset.directUploadUrl

    const uppy = Uppy({
      autoProceed: false,
      restrictions: {
        maxFileSize: 10000000,
        maxNumberOfFiles: 2,
        allowedFileTypes: ['image/*', '.pdf']
      },
      locale: Russian
    })

    // Get user's locale
    // let user_locale = document.querySelector('#uppy').dataset.locale
    uppy.use(Dashboard, {
      target: uppy_target,
      inline: true,
      height: 300,
      hideRetryButton: true,
      hidePauseResumeButton: true,
      proudlyDisplayPoweredByUppy: false
    })

    uppy.use(ASUploader, { input: input })
  }

  const uppy_photos_target = document.querySelector('#uppyPhotos')
  if (uppy_photos_target) {
    const input = document.querySelector('input[type=file]')
    const url = input.dataset.directUploadUrl

    const uppy = Uppy({
      autoProceed: false,
      restrictions: {
        maxFileSize: 20000000,
        allowedFileTypes: ['image/*', '.pdf']
      }
    })

    uppy.use(Dashboard, {
      target: uppy_photos_target,
      inline: true,
      height: 300,
      hideRetryButton: true,
      hidePauseResumeButton: true,
      proudlyDisplayPoweredByUppy: false
    })

    uppy.use(ASUploader, { input: input })
  }
})
