import { LeanWebConfig } from './docs' // look here for documentation of the individual config options

const lean4webConfig : LeanWebConfig = {
  "projects": [
    { "folder": "mathlib-demo",
      "name": "Mathlib-demo",
      "examples": [
        { "file": "MathlibLatest/Bijection.lean",
          "name": "Bijection" },
        { "file": "MathlibLatest/Logic.lean",
          "name": "Logic" },
        { "file": "MathlibLatest/Ring.lean",
          "name": "Ring" },
        { "file": "MathlibLatest/Rational.lean",
          "name": "Rational" }]},
    { "folder": "stable",
      "name": "Stable Lean" },
    {
      "folder": "mathematics_in_lean",
      "name": "mathematics_in_lean",
    }
  ],
  "serverCountry": "China",
  "contactDetails": <p>Tao Yicheng: tyc221@ruc.edu.cn</p>,
  "impressum": null
}

export default lean4webConfig
