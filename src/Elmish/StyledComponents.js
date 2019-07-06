const styled = require("styled-components").default

exports.styled_ = function(element) {
  return function(styleObject) {
    return styled(element)(styleObject)
  }
}
