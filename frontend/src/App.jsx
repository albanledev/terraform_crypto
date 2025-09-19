import "./App.css";
import { useState, useEffect } from "react";
import ShowCoin from "./component/ShowCoin";

function App() {
  const [coins, setCoins] = useState(null);

  const fetchCoin = async () => {
    const response = await fetch(
      "https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur",
      {
        headers: {
          "x-cg-demo-api-key": "CG-72Xxpib8envvUzpaQbwMbuiX",
          "Access-Control-Allow-Origin": "*",
          "Content-Type": "application/json",
        },
      }
    );

    if (response.ok) {
      const res = await response.json();
      setCoins(res);
    }
  };

  useEffect(() => {
    fetchCoin();
  }, []);

  return (
    <ul className="flex flex-col gap-4">
      {coins?.map((coin) => (
        <li
          key={coin.id}
          className="border-dashed border-2 border-white rounded-lg p-4 cursor-pointer hover:border-solid hover:opacity-50 transition"
        >
          <ShowCoin coin={coin} />
        </li>
      ))}
    </ul>
  );
}

export default App;
