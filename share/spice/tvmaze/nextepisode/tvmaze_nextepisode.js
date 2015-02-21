(function (env) {
    "use strict";

    env.ddg_spice_tvmaze_nextepisode = function(api_result){
        if (!api_result || !api_result._embedded) {
            return Spice.failed('tvmaze_nextepisode');
        }

        Spice.add({
            id: "tvmaze_nextepisode",
            name: "Entertainment",
            data: api_result,
            meta: {
                sourceName: "TVmaze",
                sourceUrl: api_result._embedded.nextepisode.url
            },
            relevancy: {
                primary: [
                    { key: 'name' },
                    { required: '_embedded.nextepisode.name' },
                    { required: '_embedded.nextepisode.airdate' },
                ]
            },
            normalize: function(item){
                var infoboxData = [
                    {
                        label: 'Show',
                        value: item.name
                    },
                    {   label: 'Airs',
                        value: dateformat(item._embedded.nextepisode.airdate)
                    },
                    {
                        label: 'Episode',
                        value: item._embedded.nextepisode.number
                    },
                    {
                        label: 'Season',
                        value: item._embedded.nextepisode.season
                    },
                    {
                        label: 'Show Type',
                        value: item.type
                    },
                    {
                        label: 'Show Status',
                        value: item.status
                    }
                ];

                if (item.network) {
                    infoboxData.push(
                        {
                            label: 'Network',
                            value: item.network.name
                        },
                        {
                            label: 'Country of origin',
                            value: item.network.country.name
                        }
                    );
                } else if (item.webChannel) {
                    infoboxData.push(
                        {
                            label: 'Web Channel',
                            value: item.webChannel.name
                        }
                    );

                    if (item.webChannel.country) {
                        infoboxData.push(
                            {
                                label: 'Country of origin',
                                value: item.webChannel.country.name
                            }
                        );
                    }
                }

                return {
                    image: item.image ? item.image.medium : null,
                    title: item._embedded.nextepisode.name,
                    description: DDG.strip_html(item._embedded.nextepisode.summary) || "Episode summary not available.",
                    infoboxData: infoboxData
                };
            },
            templates: {
                group: 'info',
                options: {
                    moreAt: true
                }
            }
        });
    };

    function dateformat (date) {
        var months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'],
            dateObj = new Date(date),
            hours = dateObj.getHours(),
            minutes = dateObj.getMinutes(),
            date = dateObj.toDateString();

        date = date.substring(0, date.lastIndexOf(" "));

        // AM or PM?
        var suffix = (hours >= 12) ? "PM" : "AM";
        // Convert to 12-hour time.
        if(hours > 12) {
            hours -= 12;
        } else if(hours === 0) {
            hours = 12;
        }
        // Add leading zeroes.
        minutes = minutes < 10 ? "0" + minutes : minutes;

        return months[dateObj.getMonth()] + " " + dateObj.getDate() + ", " + dateObj.getFullYear() + " at " + hours + ":" + minutes + " " + suffix;
    };

}(this));
