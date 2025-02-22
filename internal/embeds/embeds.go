//nolint:gochecknoglobals
package embeds

import (
	"embed"

	"github.com/styrainc/regal/bundle"
)

var EmbedBundleFS = bundle.Bundle

//go:embed templates
var EmbedTemplatesFS embed.FS

//go:embed schemas/regal-ast.json
var ASTSchema []byte
