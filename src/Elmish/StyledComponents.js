const styled = require("styled-components").default

exports.styled = function(element) {
  return function(styleObject) {
    return styled(element)(styleObject)
  }
}
