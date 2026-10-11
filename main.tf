resource "google_network_services_http_route" "network_services_http_routes" {
  for_each = var.network_services_http_routes

  hostnames       = each.value.hostnames
  name            = each.value.name
  deletion_policy = each.value.deletion_policy
  description     = each.value.description
  gateways        = each.value.gateways
  labels          = each.value.labels
  meshes          = each.value.meshes
  project         = each.value.project

  dynamic "rules" {
    for_each = each.value.rules
    content {
      dynamic "action" {
        for_each = rules.value.action != null ? [rules.value.action] : []
        content {
          dynamic "cors_policy" {
            for_each = action.value.cors_policy != null ? [action.value.cors_policy] : []
            content {
              allow_credentials    = cors_policy.value.allow_credentials
              allow_headers        = cors_policy.value.allow_headers
              allow_methods        = cors_policy.value.allow_methods
              allow_origin_regexes = cors_policy.value.allow_origin_regexes
              allow_origins        = cors_policy.value.allow_origins
              disabled             = cors_policy.value.disabled
              expose_headers       = cors_policy.value.expose_headers
              max_age              = cors_policy.value.max_age
            }
          }
          dynamic "destinations" {
            for_each = action.value.destinations != null ? action.value.destinations : []
            content {
              service_name = destinations.value.service_name
              weight       = destinations.value.weight
            }
          }
          dynamic "fault_injection_policy" {
            for_each = action.value.fault_injection_policy != null ? [action.value.fault_injection_policy] : []
            content {
              dynamic "abort" {
                for_each = fault_injection_policy.value.abort != null ? [fault_injection_policy.value.abort] : []
                content {
                  http_status = abort.value.http_status
                  percentage  = abort.value.percentage
                }
              }
              dynamic "delay" {
                for_each = fault_injection_policy.value.delay != null ? [fault_injection_policy.value.delay] : []
                content {
                  fixed_delay = delay.value.fixed_delay
                  percentage  = delay.value.percentage
                }
              }
            }
          }
          dynamic "redirect" {
            for_each = action.value.redirect != null ? [action.value.redirect] : []
            content {
              host_redirect  = redirect.value.host_redirect
              https_redirect = redirect.value.https_redirect
              path_redirect  = redirect.value.path_redirect
              port_redirect  = redirect.value.port_redirect
              prefix_rewrite = redirect.value.prefix_rewrite
              response_code  = redirect.value.response_code
              strip_query    = redirect.value.strip_query
            }
          }
          dynamic "request_header_modifier" {
            for_each = action.value.request_header_modifier != null ? [action.value.request_header_modifier] : []
            content {
              add    = request_header_modifier.value.add
              remove = request_header_modifier.value.remove
              set    = request_header_modifier.value.set
            }
          }
          dynamic "request_mirror_policy" {
            for_each = action.value.request_mirror_policy != null ? [action.value.request_mirror_policy] : []
            content {
              dynamic "destination" {
                for_each = request_mirror_policy.value.destination != null ? [request_mirror_policy.value.destination] : []
                content {
                  service_name = destination.value.service_name
                  weight       = destination.value.weight
                }
              }
            }
          }
          dynamic "response_header_modifier" {
            for_each = action.value.response_header_modifier != null ? [action.value.response_header_modifier] : []
            content {
              add    = response_header_modifier.value.add
              remove = response_header_modifier.value.remove
              set    = response_header_modifier.value.set
            }
          }
          dynamic "retry_policy" {
            for_each = action.value.retry_policy != null ? [action.value.retry_policy] : []
            content {
              num_retries      = retry_policy.value.num_retries
              per_try_timeout  = retry_policy.value.per_try_timeout
              retry_conditions = retry_policy.value.retry_conditions
            }
          }
          timeout = action.value.timeout
          dynamic "url_rewrite" {
            for_each = action.value.url_rewrite != null ? [action.value.url_rewrite] : []
            content {
              host_rewrite        = url_rewrite.value.host_rewrite
              path_prefix_rewrite = url_rewrite.value.path_prefix_rewrite
            }
          }
        }
      }
      dynamic "matches" {
        for_each = rules.value.matches != null ? rules.value.matches : []
        content {
          full_path_match = matches.value.full_path_match
          dynamic "headers" {
            for_each = matches.value.headers != null ? matches.value.headers : []
            content {
              exact_match   = headers.value.exact_match
              header        = headers.value.header
              invert_match  = headers.value.invert_match
              prefix_match  = headers.value.prefix_match
              present_match = headers.value.present_match
              dynamic "range_match" {
                for_each = headers.value.range_match != null ? [headers.value.range_match] : []
                content {
                  end   = range_match.value.end
                  start = range_match.value.start
                }
              }
              regex_match  = headers.value.regex_match
              suffix_match = headers.value.suffix_match
            }
          }
          ignore_case  = matches.value.ignore_case
          prefix_match = matches.value.prefix_match
          dynamic "query_parameters" {
            for_each = matches.value.query_parameters != null ? matches.value.query_parameters : []
            content {
              exact_match     = query_parameters.value.exact_match
              present_match   = query_parameters.value.present_match
              query_parameter = query_parameters.value.query_parameter
              regex_match     = query_parameters.value.regex_match
            }
          }
          regex_match = matches.value.regex_match
        }
      }
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

