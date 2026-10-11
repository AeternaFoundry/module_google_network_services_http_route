variable "network_services_http_routes" {
  description = <<EOT
Map of network_services_http_routes, attributes below
Required:
    - hostnames
    - name
    - rules (block):
        - action (optional, block):
            - cors_policy (optional, block):
                - allow_credentials (optional)
                - allow_headers (optional)
                - allow_methods (optional)
                - allow_origin_regexes (optional)
                - allow_origins (optional)
                - disabled (optional)
                - expose_headers (optional)
                - max_age (optional)
            - destinations (optional, block):
                - service_name (optional)
                - weight (optional)
            - fault_injection_policy (optional, block):
                - abort (optional, block):
                    - http_status (optional)
                    - percentage (optional)
                - delay (optional, block):
                    - fixed_delay (optional)
                    - percentage (optional)
            - redirect (optional, block):
                - host_redirect (optional)
                - https_redirect (optional)
                - path_redirect (optional)
                - port_redirect (optional)
                - prefix_rewrite (optional)
                - response_code (optional)
                - strip_query (optional)
            - request_header_modifier (optional, block):
                - add (optional)
                - remove (optional)
                - set (optional)
            - request_mirror_policy (optional, block):
                - destination (optional, block):
                    - service_name (optional)
                    - weight (optional)
            - response_header_modifier (optional, block):
                - add (optional)
                - remove (optional)
                - set (optional)
            - retry_policy (optional, block):
                - num_retries (optional)
                - per_try_timeout (optional)
                - retry_conditions (optional)
            - timeout (optional)
            - url_rewrite (optional, block):
                - host_rewrite (optional)
                - path_prefix_rewrite (optional)
        - matches (optional, block):
            - full_path_match (optional)
            - headers (optional, block):
                - exact_match (optional)
                - header (optional)
                - invert_match (optional)
                - prefix_match (optional)
                - present_match (optional)
                - range_match (optional, block):
                    - end (required)
                    - start (required)
                - regex_match (optional)
                - suffix_match (optional)
            - ignore_case (optional)
            - prefix_match (optional)
            - query_parameters (optional, block):
                - exact_match (optional)
                - present_match (optional)
                - query_parameter (optional)
                - regex_match (optional)
            - regex_match (optional)
Optional:
    - deletion_policy
    - description
    - gateways
    - labels
    - meshes
    - project
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    hostnames       = list(string)
    name            = string
    deletion_policy = optional(string)
    description     = optional(string)
    gateways        = optional(list(string))
    labels          = optional(map(string))
    meshes          = optional(list(string))
    project         = optional(string)
    rules = list(object({
      action = optional(object({
        cors_policy = optional(object({
          allow_credentials    = optional(bool)
          allow_headers        = optional(list(string))
          allow_methods        = optional(list(string))
          allow_origin_regexes = optional(list(string))
          allow_origins        = optional(list(string))
          disabled             = optional(bool)
          expose_headers       = optional(list(string))
          max_age              = optional(string)
        }))
        destinations = optional(list(object({
          service_name = optional(string)
          weight       = optional(number)
        })))
        fault_injection_policy = optional(object({
          abort = optional(object({
            http_status = optional(number)
            percentage  = optional(number)
          }))
          delay = optional(object({
            fixed_delay = optional(string)
            percentage  = optional(number)
          }))
        }))
        redirect = optional(object({
          host_redirect  = optional(string)
          https_redirect = optional(bool)
          path_redirect  = optional(string)
          port_redirect  = optional(number)
          prefix_rewrite = optional(string)
          response_code  = optional(string)
          strip_query    = optional(bool)
        }))
        request_header_modifier = optional(object({
          add    = optional(map(string))
          remove = optional(list(string))
          set    = optional(map(string))
        }))
        request_mirror_policy = optional(object({
          destination = optional(object({
            service_name = optional(string)
            weight       = optional(number)
          }))
        }))
        response_header_modifier = optional(object({
          add    = optional(map(string))
          remove = optional(list(string))
          set    = optional(map(string))
        }))
        retry_policy = optional(object({
          num_retries      = optional(number)
          per_try_timeout  = optional(string)
          retry_conditions = optional(list(string))
        }))
        timeout = optional(string)
        url_rewrite = optional(object({
          host_rewrite        = optional(string)
          path_prefix_rewrite = optional(string)
        }))
      }))
      matches = optional(list(object({
        full_path_match = optional(string)
        headers = optional(list(object({
          exact_match   = optional(string)
          header        = optional(string)
          invert_match  = optional(bool)
          prefix_match  = optional(string)
          present_match = optional(bool)
          range_match = optional(object({
            end   = number
            start = number
          }))
          regex_match  = optional(string)
          suffix_match = optional(string)
        })))
        ignore_case  = optional(bool)
        prefix_match = optional(string)
        query_parameters = optional(list(object({
          exact_match     = optional(string)
          present_match   = optional(bool)
          query_parameter = optional(string)
          regex_match     = optional(string)
        })))
        regex_match = optional(string)
      })))
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.network_services_http_routes : (
        length(v.rules) >= 1
      )
    ])
    error_message = "Each rules list must contain at least 1 items"
  }
}

