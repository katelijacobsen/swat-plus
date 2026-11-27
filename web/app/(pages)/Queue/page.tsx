import QueueCard from "./components/QueueCard";

const Queue = () => {
    return (
        <section className="py-6 grid-cols-1">
            <h1>Digital hjælpe kø</h1>
            <div className=" grid grid-cols-[2fr_1fr] grid-rows-2 gap-4">
                <section className="bg-amber-50 rounded-md p-4 row-start-1 row-end-3 overflow-y-scroll overflow-hidden grid gap-3.5">
                    <QueueCard></QueueCard>
                    <QueueCard></QueueCard>
                    <QueueCard></QueueCard>
                    <QueueCard></QueueCard>
                    <QueueCard></QueueCard>
                    <QueueCard></QueueCard>
                    <QueueCard></QueueCard>
                    <QueueCard></QueueCard>
                    <QueueCard></QueueCard>
                    <QueueCard></QueueCard>
                </section>
                <section className="px-4 pt-4 py-8 bg-amber-50 rounded-md text-black">
                    <h2>Brug for hjælp?</h2>
                    <form action="" className="grid gap-3.5">
                        <label htmlFor="firstname">Dit for navn</label>
                        <input className="p-1 border border-black rounded-sm" type="text" placeholder="first_name" name="first_name" />
                        <label htmlFor="location">hvor finde vi dig?</label>
                        <input className="p-1 border border-black rounded-sm" type="text" placeholder="location" name="location" />
                        <label htmlFor="issue">hvad kan vi hjælpe dig med?</label>
                        <input className="p-1 border border-black rounded-sm" type="textfield" placeholder="issue" name="issue" />
                        <button className="px-7 py-1.5 bg-blue-700 rounded-md text-white">Submit</button>
                    </form>
                </section>
            </div>
        </section>
    );
}

export default Queue;