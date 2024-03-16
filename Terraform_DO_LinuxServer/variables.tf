variable "droplet_image" {
  type        = string
  description = "the image to use for our Linux server"
}

variable "droplet_name" {
  type        = string
  description = "name of droplet"
}

variable "droplet_region" {
  type        = string
  description = "region of the droplet"
}

variable "droplet_size" {
  type        = string
  description = "the disk size of our image"
}