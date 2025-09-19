import { useEffect, useState } from "react";

const ShowCoin = ({ coin }) => {
  if (!coin) return null;

  return (
    <>
      <div className="flex flex-col items-center pb-4">
        <img src={coin.image} className="w-8" />
        <h1 className="uppercase font-bold italic">{coin.name}</h1>
      </div>

      <div className="flex flex-col justify-start w-full items-start">
        <div className="flex flex-row gap-2">
          <p>Current price :</p>
          <span>{coin.current_price}</span>
        </div>
        <div className="flex flex-row gap-2">
          <p>Highest price in 24h :</p>
          <span>{coin.high_24h}</span>
        </div>
        <div className="flex flex-row gap-2">
          <p>Lowest price in 24h :</p>
          <span>{coin.low_24h}</span>
        </div>
      </div>
    </>
  );
};

export default ShowCoin;
