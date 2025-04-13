; extends


(
 (block_mapping_pair
   key: (flow_node) @key (#eq? @key "command")
   value: (block_node
            (block_scalar) @injection.content
            (#set! injection.language "bash")
            )
   ) @block
 )
