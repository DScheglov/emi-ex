defmodule EMI do

  @doc """
  Calculates the internal rate of return for a series of cash flows represented
  by the numbers in values.

  These cash flows do not have to be even, as they would be for an annuity.
  However, the cash flows must occur at regular intervals, such as monthly or
  annually. The internal rate of return is the interest rate received for an
  investment consisting of payments (negative values) and income
  (positive values) that occur at regular periods.

  flows :: `[float]` - cash flows for each period
  eps :: `float` - the accurancy for calculations
  r0 :: `float` - the first prediction for iteration algorithm

  Returns `float`.

  ##Examples:

    iex> EMI.irr([-100, 105]) |> Float.round(6)
    0.05

  """
  def irr(flows, eps \\ 1.0e-6, r0 \\ 0.001) do
    fi(flows, (1.0 + r0), eps) - 1.0
  end

  defp fi(flows, d, eps) do
    %{s: s, s1: s1} = Enum.reduce(
      flows, %{s: 0, s1: 0, q: 1.0, q1: d, d: d, n: 0},
      fn p,  %{s: s, s1: s1, q: q, q1: q1, d: d, n: n} ->
        %{
          s: s + p / q,
          s1: s1 + n * p / q1,
          q: q1,
          q1: q1 * d,
          d: d,
          n: n + 1
        }
      end # loop body
    ) # end of reduce

    d1 = d + s / s1

    if abs(d - d1) > eps, do: fi(flows, d1, eps), else: d1

  end # end of fi

end
