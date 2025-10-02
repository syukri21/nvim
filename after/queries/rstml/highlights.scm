; Basic highlight inheritance for rstml leveraging html tags
; Tag names
((element (start_tag (tag_name) @tag))
 (element (end_tag (tag_name) @tag)))

(start_tag (tag_name) @tag)
(end_tag (tag_name) @tag)
(self_closing_tag (tag_name) @tag)

(attribute (attribute_name) @attribute)
(attribute (quoted_attribute_value (attribute_value) @string))
(text) @text

(comment) @comment
