job "{{ job | default('identity') }}" {
	datacenters = ["dc1"]
	priority = 50

	group "blue" {
	  count = {{ count_blue | default(1) }}
		task "runtime" {
			driver = "docker"
			config {
				image = "{{ image_name | default('djalexd/identity') }}:{{ version_blue | default('latest') }}"
				port_map { http = 8080 }
			}

			service {
				tags = ["{{ tags_blue | list | join('","') }}"]
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
					mbits = 30
					port "http" {}
				}
			}

		}
	}

	group "green" {
	  count = {{ count_green | default(0) }}
		task "runtime" {
			driver = "docker"
			config {
				image = "{{ image_name | default('djalexd/identity') }}:{{ version_green | default('latest') }}"
				port_map { http = 8080 }
			}

			service {
				tags = ["{{ tags_green | list | join('","') }}"]
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
					mbits = 30
					port "http" {}
				}
			}

		}
	}
}
