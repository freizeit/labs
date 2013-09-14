fizzbuzz = fn
    0, 0, _ ->
        "FizzBuzz"
    0, _, _ -> "Fizz"
    _, 0, _ -> "Buzz"
    _, _, c -> c
end

rem = fn n ->
    fizzbuzz.(rem(n,3), rem(n,5), n)
end

IO.puts fizzbuzz.(0, 0, 1)
IO.puts fizzbuzz.(0, 2, 3)
IO.puts fizzbuzz.(4, 0, 5)
IO.puts fizzbuzz.(6, 7, 8)

IO.puts("-------")

IO.puts rem.(10)
IO.puts rem.(11)
IO.puts rem.(12)
IO.puts rem.(13)
IO.puts rem.(14)
IO.puts rem.(15)
IO.puts rem.(16)

