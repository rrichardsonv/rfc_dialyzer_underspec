# OddDialyzerExample

If you're like me, you were probably working with a mental model of dialyzer that went like this:

I have function `foo`, due to the guards and pattern matching present on it's function heads it only accepts inputs `:a`, `:b`, and `:c`

```elixir
def foo(:a), do: :ok
def foo(bar) when bar in [:b, :c], do: :also_ok
```

I'm going to write a spec for it like the responsible dev I am

```elixir
@spec foo(:a | :b | :c) :: :ok | :also_ok
```

And then dialyzer runs and... wtf

```
Type specification is a supertype of the success typing.

Function:
foo/1

Type specification:
@spec foo(:a | :b | :c) :: :ok | :also_ok

Success typing:
@spec foo(:a | :b) :: :ok | :also_ok
```

_(Now in real life this is far more likely to happen with maps)_

You puzzle over it for a while, fiddle and then ultimately either remove the spec (suddenly... it passes 🧙‍♂️ !?) or copy and paste the success typing in place of your spec (which also passes? That can't be right...)

The confusion your feeling comes from thinking dialyzer cares about the atomic composition of your functions with regards to inputs. It does not.

It only cares about the function(s) that call `foo`:

```elixir
  def a do
    foo(:a)
  end

  def b do
    foo(:b)
  end
```

...and that the type aggregated from all real inputs (identifiable at compilation time) is _congruent_ (ie: identical in form; coinciding _exactly_ when superimposed) with the parameters accepted by a given interface.

Want to accurately describe the interface of your utility function? Tough.

Want to clearly type and document all options your function accepts? Better be using every. single. one.

I find this to be a significant problem and my understanding is this is driven by the `:underspecs` option given to dialyzer. Does that option only include this behaviour or encompass more?

Given...
- the nature of modern iterative development
- that option only encompasses the behaviour described above

I argue we remove that option from our dialyzer runs as it punishes positive practices and extorts negative behaviours ultimately diluting the quality of our codebase.

## To see the error

```
mix deps.get && mix dialyzer
```