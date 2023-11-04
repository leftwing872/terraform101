variable "number_example" {
	description = "An example of a number variable in Terraform"
	type = number
	default = 2
}

variable "list_example" {
	description = "An example of list in Terraform"
	type = list
	default = ["a", "b", "c"]
}

#제약조건 결합
variable "list_numeric_example" {
	description = "An example of numericlist in Terraform"
	type = list(number)
	default = [1, 2, 3]
}

variable "map_example" {
	description = "An example of a map in Terraform"
	type = map(string)
	
	default = {
		key1 = "value1"
		key2 = "value2"
		key3 = "value3"	
	}
}

variable "object_example" {
	description = "An example of astructual type in Terraform"
	type = object({
		name = string
		age = number
		tags = list(string)
		enabled = bool
	})
    
	default = {
		name = "value1"
		age = 42
		tags = ["a", "b", "c"]
		enabled = true
	}
}
