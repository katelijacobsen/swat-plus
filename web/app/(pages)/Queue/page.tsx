import QueueCard from "./components/QueueCard";

const Queue = () => {
    return (
        <section className="max-h-full pt-6 grid grid-cols-1 grid-rows-[1fr_8fr]">
            <div className="flex gap-3.5 items-end pb-3.5">
                <h1 className="text-trim self-end" >Digital hjælpe kø</h1>
                <p className="text-trim">x i kø</p>
            </div>
            <div className="max-h-120 grid grid-cols-[2fr_1fr] grid-rows-1 gap-4 overflow-hidden">
                <section className=" bg-amber-50 rounded-md p-4 overflow-y-scroll grid gap-3.5">
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
                    <QueueCard></QueueCard>
                    <QueueCard></QueueCard>
                    <QueueCard></QueueCard>
                    <QueueCard></QueueCard>
                </section>
                <section className="h-full px-4 pt-4 pb-8 bg-amber-50 rounded-md text-black grid grid-rows-[1fr_8fr]">
                    <h2>Brug for hjælp?</h2>
                    <form action="" className="h-full grid gap-3.5 self-start">
                        <div className="h-fit grid grid-cols-1">
                            <label htmlFor="firstname">Dit for navn</label>
                            <input className="h-9 p-1.5 border border-black rounded-sm" type="text" placeholder="first_name" name="first_name" />
                        </div>
                        <div className="h-fit grid grid-cols-1">
                            <label htmlFor="location">hvor finde vi dig?</label>
                            <input className="h-9 p-1.5 border border-black rounded-sm" type="text" placeholder="location" name="location" />
                        </div>
                        <div className="h-fit grid grid-cols-1">
                            <label htmlFor="issue">hvad kan vi hjælpe dig med?</label>
                            <input className="h-9 p-1.5 border border-black rounded-sm" type="textfield" placeholder="issue" name="issue" />
                        </div>
                        <button className="px-7 py-1.5 bg-blue-700 rounded-md text-white self-end">Submit</button>
                    </form>
                </section>
            </div>
        </section>
    );
}

export default Queue;