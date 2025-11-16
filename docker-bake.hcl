group "default" {
  targets = ["default"]
}

variable "BASE_IMAGE_TAG" {
  type = string
  default = "3.4.7-alpine3.22"
}
variable "MAILCATCHER_VERSION" {
  type = string
  default = "0.10.0"
}

variable "GITHUB_REF_NAME" {
  type = string
  default = ""
}
variable "GITHUB_REF_TYPE" {
  type = string
  default = ""
}

target "default" {
  args = {
    BASE_IMAGE_TAG = "${BASE_IMAGE_TAG}",
    MAILCATCHER_VERSION = "${MAILCATCHER_VERSION}",
  }
  tags = [
    "geokrety/mailcatcher:latest",
    "geokrety/mailcatcher:${MAILCATCHER_VERSION}",
    "geokrety/mailcatcher:${MAILCATCHER_VERSION}-${BASE_IMAGE_TAG}",
    notequal(GITHUB_REF_NAME, "") ? "geokrety/mailcatcher:${replace(GITHUB_REF_NAME, "/", "-")}-${MAILCATCHER_VERSION}" : "",
    notequal(GITHUB_REF_NAME, "") ? "geokrety/mailcatcher:${replace(GITHUB_REF_NAME, "/", "-")}-${MAILCATCHER_VERSION}-${BASE_IMAGE_TAG}" : "",
  ]
}
