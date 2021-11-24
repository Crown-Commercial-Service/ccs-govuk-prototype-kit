const express = require('express')
const router = express.Router()

// Add your routes here - above the module.exports line

router.get('/example', (_, res) => {
  res.render('ccs_example/example/index')
})

module.exports = router
