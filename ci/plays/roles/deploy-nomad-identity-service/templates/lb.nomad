job "lb" {
	datacenters = ["dc1"]
	priority = 50

	update {
		stagger = "10s"
		max_parallel = 1
	}

	# Create a 'cache' group. Each task in the group will be
	# scheduled onto the same machine.
	group "cache" {
		count = {{ count | default(1) }}
		restart {
			attempts = 10
			interval = "5m"
			delay = "25s"
			mode = "delay"
		}
		# Define a task to run
		task "identity" {
			driver = "docker"
			config {
				image = "djalexd/identity:latest"
				port_map {
					http = 8080
				}
				#network_mode = "host"
			}

			service {
				tags = [ "service", "identity" ]
				port = "http"
				check {
          type     = "tcp"
          port     = "http"
          interval = "10s"
          timeout  = "2s"
        }
			}

			resources {
				cpu = 500
				memory = 192
				network {
					mbits = 10
					port "http" {}
				}
			}
		}
	}
}
