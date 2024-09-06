/** Expected arguments which can be provided in the URL. */
interface UrlArgs {
    project: string | null
    url: string | null
    code: string | null
    codez: string | null
  }

/** Escape `(` and `)` in URL. */
export function fixedEncodeURIComponent(str: string) {
return encodeURIComponent(str).replace(/[()]/g, function(c) {
    return '%' + c.charCodeAt(0).toString(16);
})
}

/**
 * Format the arguments for displaying in the URL, i.e. join them
 * in the form `#project=Mathlib&url=...`
 */
export function formatArgs(args: UrlArgs): string {
    let out = '#' +
      Object.entries(args).filter(([_key, val]) => (val !== null && val.trim().length > 0)).map(([key, val]) => (`${key}=${val}`)).join('&')
    if (out == '#') {
      return ' '
    }
    return out
  }

/**
 * Parse arguments from URL. These are of the form `#project=Mathlib&url=...`
 */
export function parseArgs(): UrlArgs {
    let _args = window.location.hash.replace('#', '').split('&').map((s) => s.split('=')).filter(x => x[0])
    return Object.fromEntries(_args)
  }
