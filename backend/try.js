const flattenTheDict = (originalDict, currentList) => {
  currentList.push({
    title: originalDict["title"],
    content: originalDict["content"],
  });
  if (originalDict["items"] !== undefined) {
    originalDict["items"].forEach((ele) => {
      currentList = flattenTheDict(ele, currentList);
    });
  }
  return currentList;
};

let contentList = [
  {
    title: "History",
    content:
      "After the dissolution of the Soviet Union, many formerly Soviet launch vehicles were built in or required components from companies now located in Ukraine, such as Yuzhnoye Design Bureau, which produced Zenit-2, and Yuzhmash, which produced Dnepr and Tsyklon. Additionally, the Soviet Union's main spaceport, Baikonur Cosmodrome, was located in Kazakhstan, and Russia encountered difficulties negotiating for its use. This led to the decision in 1992 to develop a new entirely Russian launch vehicle, named Angara, to replace the launch vehicles now built outside of the country, and ensure Russian access to space without Baikonur. It was decided that this vehicle should ideally use the partially completed Zenit-2 launch pad at the Russian Plesetsk Cosmodrome, and be able to launch military satellites into geosynchronous orbit, which Proton could not due to lack of a launch pad at Plesetsk Cosmodrome. Several companies submitted bids for the new launch vehicle, and in 1994 Khrunichev, the developer of Proton, was selected as the winner. The commercial success of Proton over the next two decades would be an advantage to Khrunichev, as the Angara project immediately ran into funding difficulties from the cash-strapped Russian government.Khrunichev's initial design called for the use of a modified RD-170 for first stage propulsion and a liquid hydrogen powered second stage. By 1997, the hydrogen-powered second stage had been abandoned in favor of kerosene, and the RD-170 was replaced with a modular design which would be powered by the new RD-191, a one-chamber engine derived from the four-chamber RD-170. In late 1997, Khrunichev was given approval from the Russian government to proceed with their new design, which would both be able to replace the ICBM-based Dnepr, Tsyklon, and Rokot with its smaller variants, as well as be able to launch satellites into geostationary orbit from Plesetsk with the Proton-class Angara A5.By 2004, the design of Angara had taken shape and the project proceeded with development of the launchers. In 2008, NPO Energomash, the builder of the RD-191, reported that the engine had completed development and burn tests and was ready for manufacturing and delivery, and in January 2009 the first completed Angara first stage was delivered to Khrunichev. The next year Vladimir Nesterov, Director-General of Khrunichev, announced that the first flight test of Angara would be scheduled for 2013, and in 2013 the first prototype Angara launch vehicle arrived in Plesetsk.In 2014, 22 years after Angara's original conception, the first launch took place on 9 July 2014, an Angara 1.2PP suborbital test flight from the northern Plesetsk Cosmodrome. On 23 December 2014, Angara A5's first test flight was performed, launching it into geosynchronous orbit. In June 2020, it was reported that the first Angara Launching Pad was completed and would be transported to Vostochny Cosmodrome.On 14 December 2020, 6 years after the first test flight, Angara-A5's second test flight took place from Plesetsk. According to Roscosmos chief Dmitriy Rogozin, two more Angara launches are coming in 2021: an Angara-1.2 and an Angara-A5 with a new booster, Persei.",
  },
  {
    title: "Vehicle description",
    content: "",
    items: [
      {
        title: "URM-1: first stage and boosters",
        content:
          "The Universal Rocket Module (URM-1) forms the core of every Angara vehicle. In the Angara A5, four additional URM-1s act as boosters. Each URM-1 is powered by a single NPO Energomash RD-191 burning liquid oxygen and RP-1 (kerosene).The RD-191 is a single-chamber engine derived from the four-chamber RD-170, originally developed for the boosters powering the Energia launch vehicle. Zenit's four-chamber RD-171 and the dual-chamber RD-180 powering ULA's Atlas V are also derivatives of the RD-170, as is the RD-193 proposed as a replacement for the 1970s-era NK-33 powering the first stage of the Soyuz 2.1v. The RD-191 is capable of throttling down to at least 30%, allowing core URM-1 stages to conserve propellant until booster URM-1 separation.The URM-1 consists of a liquid oxygen tank at the top, followed by an intertank structure containing flight control and telemetry equipment, with the kerosene tank below that. At the base of the module is a propulsion bay containing engine gimballing equipment for vehicle pitch and yaw and thrusters for roll control.",
      },
      {
        title: "URM-2: second stage",
        content:
          "The second stage of the Angara, designated URM-2, uses one KBKhA RD-0124A engine also burning liquid oxygen and kerosene. The RD-0124A is nearly identical to the RD-0124 currently powering the second stage of Soyuz-2, designated Block I. The URM-2 has a diameter of 3.6 m (12 ft) for the Angara A5 and other proposed variants. The Angara 1.2 will fly a smaller RD-0124A-powered second stage, which may be 2.66 m (8 ft 9 in) to maintain commonality with Block I or stretched to 2.9 m (9 ft 6 in) to maintain a consistent diameter with URM-1.",
      },
      {
        title: "Upper stages",
        content:
          "Angara 1.2 will not use an upper stage, nor will Angara A5 when delivering payloads to low orbits. For higher energy orbits such as GTO, Angara A5 will use the Briz-M upper stage (currently used for the Proton-M rocket), powered by one S5.98M burning N2O4 and UDMH, or eventually a new cryogenic upper stage, the KVTK. This stage will use the LH2/LOX powered RD-0146D and allow Angara A5 to bring up to two tonnes more mass to GTO. The Blok D is being considered as an upper stage when launched from Vostochny since it will avoid the toxic propellant of the Briz-M.",
      },
    ],
  },
  {
    title: "Variants",
    content: "",
    items: [
      {
        title: "Angara 1.2",
        content:
          "The smallest Angara under development is the Angara 1.2, which consists of one URM-1 core and a modified Block I second stage. It has a lift-off mass of 171 tonnes and can deliver 3.8 tonnes of payload to a 200 km (120 mi) x 60° orbit.",
        items: [
          {
            title: "Angara 1.2pp",
            content:
              "A modified Angara 1.2, called Angara 1.2PP (Angara-1.2 pervyy polyot, meaning Angara-1.2 first flight), made Angara's inaugural suborbital flight on 9 July 2014. This flight lasted 22 minutes and carried a mass simulator weighing 1,430 kg (3,150 lb). Angara 1.2PP weighed 171,000 kg (377,000 lb) and consisted of a URM-1 core stage and a partially fueled 3.6 m (12 ft)-diameter URM-2, allowing each of the major components of Angara A5 to be flight tested before that version's first orbital launch, conducted on 23 December 2014.",
          },
        ],
      },
      {
        title: "Angara A5",
        content:
          "The second Angara developed was the Angara A5 heavy lift launch vehicle, which consists of one URM-1 core and four URM-1 boosters, a 3.6m URM-2 second stage, and an upper stage, either the Briz-M or the KVTK. Weighing 773 tonnes at lift-off, Angara A5 has a payload capacity of 24.5 tonnes to a 200 km (120 mi) x 60° orbit. Angara A5 is able to deliver 5.4 tonnes to GTO with Briz-M, or 7.5 tonnes to the same orbit with KVTK.In the Angara A5, the four URM-1s used as boosters operate at full thrust for approximately 214 seconds, then separate. The URM-1 forming the vehicle's core is operated at full thrust for lift off, then throttled down to 30% to conserve propellant. The core is throttled back up after the boosters have separated and continues burning for another 110 seconds.The first Angara A5 test flight was launched on 23 December 2014. The second test flight was launched on 14 December 2020 from Plesetsk. A third test flight was launched on 27 December 2021, also from Plesetsk. However, the test of Persei upper stage failed and the payload did not make it from LEO to GEO.",
      },
      {
        title: "Proposed versions",
        content: "",
        items: [
          {
            title: "Angara 1.1",
            content:
              "Initial plans called for an even smaller Angara 1.1 using a Briz-KM as a second stage, with a payload capacity of 2 tonnes. This version was cancelled as it fell into the same payload class as the Soyuz 2.1v, which made its debut flight in 2013.",
          },
          {
            title: "Angara A3",
            content:
              "The Angara A3 would consist of one URM-1 core, two URM-1 boosters, the 3.6m URM-2, and an optional Briz-M or hydrogen powered upper stage for high energy orbits. The hydrogen powered stage for this vehicle, called RCAF would be smaller than the Angara A5's KVTK. This vehicle has no current plans for use (14.6 tonnes to 200 km x 60°, 2.4 tonnes to GTO with Briz-M or 3.6 tonnes with a hydrogen upper stage), but could be developed as a replacement for Zenit.",
          },
          {
            title: "Angara A5P",
            content:
              "Khrunichev has proposed an Angara A5 capable of launching a new crewed spacecraft weighing up to 18 tonnes: the Angara 5P. This version would have 4 URM-1s as boosters surrounding a sustainer core URM-1 but lack a second stage, relying on the spacecraft to complete orbital insertion from a slightly suborbital trajectory, much like the Buran or Space Shuttle. This has the advantage of allowing all engines to be lit and checked out while on the ground, eliminating the possibility of an engine failing to start after staging. The RD-191 engines may also be operated at reduced thrust to improve safety.",
          },
          {
            title: "Angara A5V",
            content:
              "Khrunichev has proposed an upgraded Angara A5 variant with a new big hydrogen-based upper stage (URM-2V) as replacement for URM-2 and upgraded engine thrust on the URM-1 stages. The thrust up the URM-1 boosters would be 10% higher during the first 40 seconds to allow good thrust/weight ratio even with the URM-2 replaced with the heavier URM-2V. Cross-feed and even more powerful RD-195 engines for the URM-1 are also considered. The capacity of A5V is supposed to be around 35-40 tonnes to LEO depending on final configuration.",
          },
          {
            title: "Angara A7",
            content:
              "Proposals exist for a heavier Angara A7, weighing 1133 tonnes and capable of putting 35 tonnes into a 200 km (120 mi) x 60° orbit, or delivering 12.5 tonnes to GTO with an enlarged KVTK-A7 as a second stage in place of the URM-2. There are no current plans to develop this vehicle as it would require a larger core URM-1 to carry more propellant and would have to await the development of the hydrogen powered engine for KVTK. The Angara A7 would also require a different launch pad.",
          },
          {
            title: "Angara-100",
            content:
              "The Angara-100 was a 2005 proposal by Khrunichev to build a heavy-lift launch vehicle for NASA's Vision for Space Exploration. The rocket would consist of four RD-170-powered boosters, an RD-180-powered core stage, and a cryogenic upper stage using a modified Energia RD-0120 engine, the RD-0122. Its payload capacity to LEO would be in excess of 100 tons.",
          },
          {
            title: "Baikal",
            content:
              "Together with NPO Molniya, Khrunichev has also proposed a reusable URM-1 booster named Baikal. The URM-1 would be fitted with a wing, an empennage, a landing gear, a return flight engine and attitude control thrusters, to enable the rocket booster to return to an airfield after completing its mission.",
          },
        ],
      },
    ],
  },
  {
    title: "Specifications",
    content: "",
    items: [
      {
        title: "Active",
        content: "",
      },
      {
        title: "Cancelled or proposed",
        content: "",
      },
    ],
  },
  {
    title: "Testing and manufacturing",
    content:
      "The production of the Universal Rocket Modules and the Briz-M upper stages will take place at the Khrunichev subsidiary Production Corporation Polyot in Omsk. In 2009, Polyot invested over 771.4 million RUB (about US$25 million) in Angara production lines. Design and testing of the RD-191 engine was done by NPO Energomash, while its mass production will take place at the company Proton-PM in Perm, Russia.",
  },
  {
    title: "Launches",
    content: "",
    items: [
      {
        title: "Facilities",
        content:
          "Angara will primarily be launched from the Plesetsk Cosmodrome. Beginning in 2020, as of 2014, plans called for it to also be launched from the Vostochny Cosmodrome. This would have allowed the phase out of Proton, a rocket whose operation at Baikonur Cosmodrome, Kazakhstan has been objected to due to its use of large amounts of highly toxic UDMH and N2O4 and reliability issues.",
      },
      {
        title: "Launch history",
        content: "",
      },
    ],
  },
  {
    title: "Related projects",
    content:
      "The South Korean launch vehicle Naro-1 used a first stage derived from Angara's URM-1 (fitted with a lower-thrust version of the RD-191 engine called RD-151). The vehicle made its first flight on 25 August 2009. The flight was not successful, but the first stage operated as expected. A second launch on 10 June 2010 ended in failure, when contact with the rocket was lost 136 seconds after launch. The Joint Failure Review Board failed to come to a consensus on the cause of the failure. The third flight on 30 January 2013 successfully reached orbit.",
  },
  {
    title: "Comparable rockets",
    content: "",
  },
  {
    title: "See also",
    content:
      "Comparison of orbital launchers families\nComparison of orbital launch systems",
  },
  {
    title: "References",
    content: "",
  },
  {
    title: "External links",
    content:
      "«Ангара» с омским паспортом\nAngara family page by the Khrunichev Center (in Russian)\nAngara family, at Encyclopedia Astronautica\nAngara family, at RussianSpaceWeb",
  },
].map((ele) => {
  return flattenTheDict(ele, []);
});
console.log(contentList);
