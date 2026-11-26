import Card from "./global/components/Card";
import OnDuty from "./global/components/OnDuty";


export default function Home() {
  return (
    <main className="fullbleed bg-mauve-200">
      <h1>Dashboard</h1>
      <div className=" grid grid-cols-[2fr_1fr] grid-rows-[4fr_1fr] gap-6 ">
        <section className="h-full grid grid-cols-2 grid-rows-2 gap-4">
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
      </div>
    </main>

  );
}
