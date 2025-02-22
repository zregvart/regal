# METADATA
# description: Custom function may be replaced by `in` keyword
package regal.rules.idiomatic["custom-in-construct"]

import future.keywords.contains
import future.keywords.if
import future.keywords.in

import data.regal.result

report contains violation if {
	some rule in input.rules
	rule.head.args

	arg_names := [arg.value | some arg in rule.head.args]

	# while there could be more convoluted ways of doing this
	# we'll settle for the likely most common case (`item == coll[_]`)
	count(rule.body) == 1

	terms := rule.body[0].terms

	terms[0].value[0].type == "var"
	terms[0].value[0].value in {"eq", "equal"}

	[var, ref] := normalize_eq_terms(terms)

	var.value in arg_names
	ref.value[0].value in arg_names
	ref.value[1].type == "var"
	startswith(ref.value[1].value, "$")

	violation := result.fail(rego.metadata.chain(), result.location(rule.head))
}

# METADATA
# description: Normalize var to always always be on the left hand side
normalize_eq_terms(terms) := [terms[1], terms[2]] if {
	terms[1].type == "var"
	terms[2].type == "ref"
	terms[2].value[0].type == "var"
}

normalize_eq_terms(terms) := [terms[2], terms[1]] if {
	terms[1].type == "ref"
	terms[1].value[0].type == "var"
	terms[2].type == "var"
}
