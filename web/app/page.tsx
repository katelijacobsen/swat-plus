import Link from "next/link";
import Card from "./global/components/Card";
import OnDuty from "./global/components/OnDuty";


export default function Home() {
  return (
    <main className="fullbleed bg-mauve-200">
      <div className="h-full grid grid-rows-[1fr_5fr_1fr]">
        <div className="h-fit grid self-end items-end">
          <p className="uppercase"> Fredag 27. November</p>
          <h1 className="self-end pb-4">Dashboard</h1>
        </div>
        <div className=" grid grid-cols-[2fr_1fr] grid-rows-[4fr_1fr] gap-6 ">
          <section className="h-fit grid grid-cols-2 grid-rows-2 gap-9">
            <Card></Card>
            <Card></Card>
            <Card></Card>
            <Card></Card>
          </section>
          <section className="bg-amber-50 rounded-md p-6">
            <h2>Tutorer og fagområder</h2>
            <p>på vagt i lektiecaféen</p>
            <div className="py-7 grid gap-6">
              <OnDuty></OnDuty>
              <OnDuty></OnDuty>
            </div>
          </section>
          <section className="bg-amber-50 col-span-full  grid grid-cols-[2fr_1fr] grid-rows-2 p-6">
            <h2>Digital hjælpe kø</h2>
            <p>2 studerende i kø</p>
            <Link className="w-fit px-7 py-1.5 col-end-3 row-start-1 row-end-3 self-center justify-self-end bg-blue-700 rounded-md" href="#">Stil dig i kø her</Link>
          </section>
        </div>
      </div>
    </main>

  );
}
