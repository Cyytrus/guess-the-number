defmodule Guess do
  use Application

  def start(_,_) do
    run()
    {:ok, self()}
  end
  def run() do
    IO.puts("Bó jogar um jogo aí cumpadi")

    IO.gets("Escolha a dificuldade do jogo.Os níveis serão divididos entre 1, 2 e 3: ")
    |> parse_input()
    |> pickup_number()
    |> play
  end

  def pickup_number(level) do
    level
    |> get_range()
    |> Enum.random()
  end

  def play(picked_num) do
    IO.gets("Já escolhi meu número, adivinha aí.\n")
    |> parse_input()
    |> guess(picked_num, 1)
  end

  def guess(usr_guess, picked_num, count) when usr_guess > picked_num do
    IO.gets("Chutou alto demais.\n")
    |> parse_input()
    |> guess(picked_num, count + 1)
  end

  def guess(usr_guess, picked_num, count) when usr_guess < picked_num do
    IO.gets("Chutou baixo demais.\n")
    |> parse_input()
    |> guess(picked_num, count + 1)
  end

  def guess(_usr_guess, _picked_num, count) do
    IO.puts("Acertou com #{count} tentativas!")
    show_score(count)
  end

  def show_score(guesses) when guesses > 6 do
    IO.puts("HORRÍVELLLLLLL, NA PRÓXIMA VC CONSEGUE")
  end

  def show_score(guesses) do
    {_, msg} = %{1..1 => "Cê é bom em!",
      2..4 => "Foi uma quantidade razoável!",
      5..7 => "Treina mais"}
      |> Enum.find(fn {range, _} ->
        Enum.member?(range, guesses)
      end)
    IO.puts(msg)
  end
  def parse_input(:error) do
    IO.puts("Dados inválidos")
    run()
  end

  def parse_input({num, _}), do: num

  def parse_input(data) do
    data
    |> Integer.parse()
    |> parse_input()
  end

  def get_range(level) do
    case level do
      1 -> 1..10
      2 -> 1..100
      3 -> 1..1000
      _ -> IO.puts ("Dados inválidos")
      run()
    end
  end
end
