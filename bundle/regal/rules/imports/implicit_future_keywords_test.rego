package regal.rules.imports_test

import future.keywords.if

import data.regal.config
import data.regal.rules.imports.common_test.report

test_fail_future_keywords_import_wildcard if {
	report(`import future.keywords`) == {{
		"category": "imports",
		"description": "Use explicit future keyword imports",
		"related_resources": [{
			"description": "documentation",
			"ref": config.docs.resolve_url("$baseUrl/$category/implicit-future-keywords", "imports"),
		}],
		"title": "implicit-future-keywords",
		"location": {"col": 8, "file": "policy.rego", "row": 3, "text": `import future.keywords`},
		"level": "error",
	}}
}

test_success_future_keywords_import_specific if {
	report(`import future.keywords.contains`) == set()
}

test_success_future_keywords_import_specific_many if {
	report(`
    import future.keywords.contains
    import future.keywords.if
    import future.keywords.in
    `) == set()
}
