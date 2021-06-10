variable "teststring" {
  type        = string
  description = "String variable test."
}

variable "testlist" {
  type        = list(string)
  description = "List variable test."
}

variable "testmap" {
  type        = map(string)
  description = "Map of strings variable test."
}

variable "secretstring" {
  type        = string
  description = "Sensitive string variable test."
}

variable "secretlist" {
  type        = list(string)
  description = "Sensitive list variable test."
}

variable "secretmap" {
  type        = map(string)
  description = "Sensitive map variable test."
}