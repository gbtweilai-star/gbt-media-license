# media_license

**One capability bit from GBT V8, packaged standalone.** No. 328 of 341,
`video` domain (Video).

<p>
<img alt="python" src="https://img.shields.io/badge/python-3.9%2B-blue">
<img alt="license" src="https://img.shields.io/badge/license-MIT-green">
<img alt="deps" src="https://img.shields.io/badge/runtime%20dependencies-0-brightgreen">
</p>

> 素材许可账（三方向流程台「家规第 2 条：没有许可的素材不许进成品格」的数据源）：`register` 逐件登记（**现算 sha256** + 出处 + 授权 + 时间）、`unregister` 撤销（**必须写 why**，留档在 removed）、`status`/`list`/`check` 只读核对（账↔盘：陈旧 / sha 对不上 / 漏登）。🔴 **source 与 license 为空一律拒绝**——空着的许可记录比没有记录更坏（让人以为查过了）。只登记盘上真有的仓内素材；写面只落 `projects/_shared/licenses/`。**只登记与核对，不判定授权是否真实/充分**（那是主人的事）。

That description is copied verbatim from the registry. `tests/test_spec.py` pins it,
so documentation drift fails the build instead of shipping quietly.

## What this package actually is

It is the **contract** for one capability: its name, its parameters, the values it
accepts, and whether it can change state that cannot be restored. It is not the
implementation — that lives in the runtime this bit was extracted from.

So `run()` goes through a narrow `Backend` protocol, and the default backend is a
stub that **says so**:

```
status="validated"   backend="stub"   data={"executed": false}
```

Never `status="ok"`. A stub that reports success is worse than no stub, because the
caller stops looking for the real thing.

## Install

```bash
git clone https://github.com/gbtweilai-star/gbt-media-license.git
cd gbt-media-license
python -m pip install -e ".[dev]"
```

## Use

```bash
python -m gbt_media_license info                  # capability card
python -m gbt_media_license spec --json           # machine-readable contract
python -m gbt_media_license check --payload '{}'
python -m gbt_media_license run   --payload '{}'
```

Real `info` output from this machine:

```text
media_license  (video)  v1.0.0
----------------------------------------
素材许可账（三方向流程台「家规第 2 条：没有许可的素材不许进成品格」的数据源）：`register` 逐件登记（**现算 sha256** + 出处 + 授权 + 时间）、`unregister` 撤销（**必须写 why**，留档在 removed）、`status`/`list`/`check` 只读核对（账↔盘：陈旧 / sha 对不上 / 漏登）。🔴 **source 与 license 为空一律拒绝**——空着的许可记录比没有记录更坏（让人以为查过了）。只登记盘上真有的仓内素材；写面只落 `projects/_shared/licenses/`。**只登记与核对，不判定授权是否真实/充分**（那是主人的事）。

gated      : True   <- needs explicit consent
external   : False
multi-op   : False
params     : (none)
```

Wire a real implementation:

```python
from gbt_media_license import run

class MyBackend:
    name = "my-backend"
    def invoke(self, cap, payload):
        return {"cap": cap, "handled": sorted(payload)}

result = run({}, backend=MyBackend())
assert result.status == "ok"
```

## Parameters

| name | required | notes |
|---|---|---|
| — | no | the registry declares no required parameters |

Registry hint (`params_hint`): (empty)

Types are deliberately absent: the registry does not declare them, and an invented
type is worse than no type, because callers believe it.

## Boundaries

- Gated: this bit is marked `safe: false` in the registry — it can change state that no inverse action restores.
- No external service dependency declared.
- Single-action bit.
- No implementation ships here. Bring a backend; the protocol is one method.

## What this is not

Not a wrapper around a hosted API. Not a model. Not a promise that calling it does
anything on its own. It is the typed seam plus the validation, which is the part that
stays correct even when the implementation changes.

## Tests

```bash
python -m pytest
```

```text
20 passed, 3 skipped in 0.16s
```

## Provenance

| field | value |
|---|---|
| capability | `media_license` |
| domain | `video` |
| handler | `media_license` |
| safe | `False` (gated = `True`) |
| external | `False` |
| atlas page | [video/media_license](https://github.com/gbtweilai-star/gbt-caps/blob/main/caps/video/media_license.md) |
| full index | [https://github.com/gbtweilai-star/gbt-caps](https://github.com/gbtweilai-star/gbt-caps) |

The parent README says 348 capabilities; an AST pass over the registry enumerates
`341 + 0 unimplemented + 0 disabled = 341`. The extra 7 are historical duplicates.
Numbering here follows 341 and matches the `gbt-caps` index one-to-one.

## License

MIT.
