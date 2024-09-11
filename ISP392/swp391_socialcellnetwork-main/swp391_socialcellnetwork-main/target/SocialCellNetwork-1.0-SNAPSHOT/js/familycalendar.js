$(document).ready(function () {
    var eventsFamilyData = document.getElementById('eventsFamilyData');
    var jsonData = eventsFamilyData ? eventsFamilyData.innerHTML : '[]';
    var familyEvent = JSON.parse(jsonData);

    var events = [];
    var eventCountMap = new Map();
    var extraEventsMap = new Map();

    function addFamilyEvent(event) {
        let date = event.start;
        let count = eventCountMap.get(date) || 0;

        if (count < 3) {
            eventCountMap.set(date, count + 1);
            events.push(event);
        } else {
            let extraCount = extraEventsMap.get(date) || 0;
            extraEventsMap.set(date, extraCount + 1);
        }
    }
    ;
    familyEvent.forEach(event => {
        addFamilyEvent({
            title: ` ${event.title}`,
            start: event.start_date.toString().substring(0, 12),
            color: '#f7e798e8',
            textColor: 'black'
        });
    });

    addFamilyEvent({
        title: "  Lunar Day",
        start: "Feb 10, 2024",
        color: "#F08080",
        textColor: 'black'
    });
    extraEventsMap.forEach((count, date) => {
        events.push({
            title: `+ ${count} events`,
            start: date,
            color: '#DEB887',
            textColor: 'black'
        });
    });
    $('#calendar').fullCalendar({
        selectable: true,
        selectHelper: true,
        select: function () { },
        eventClick: function (event) {
            let familyid = document.getElementById("family_id").value;
            console.log(familyid);
            selectedDate = event.start.format('YYYY-MM-DD');
//             alert('Hello! You clicked on ' + selectedDate);
            window.location.href = 'showfamilyevent?date=' + encodeURIComponent(selectedDate) + '&familyid=' + encodeURIComponent(familyid);

        },
        dayClick: function (date) {
            selectedDate = date.format('YYYY-MM-DD');
            alert('Hello! You clicked on ' + selectedDate);
        },

        header: {
            left: 'month, comingUp',
            center: 'title',
            right: 'prev, today, next'
        },
        buttonText: {
            today: 'Today',
            month: 'Month'
        },
        events: events,
        customButtons: {
            comingUp: {
                text: 'Comingup',
                click: function () {
                    $('#upComingFamily').modal('show');

                }
            }
        },
        dayRender: function (day, cell) {
            displayLunarDate(day, cell);
        },
        eventRender: function (event, element) {
//            console.log(event);
        }
    });
});


function displayLunarDate(date, cell) {
    const lunarDate = convertSolar2Lunar(
            date.date(),
            date.month() + 1,
            date.year(),
            7
            );
    const lunarText = `${lunarDate[0]}/${lunarDate[1]}${
            lunarDate[3] ? ' (leap month)' : ''
            }`;
    const lunarDiv = $('<div class="lunar-date"></div>').text(lunarText);
    cell.append(lunarDiv);
}


// Funtion convert lunar -> solar and solar -> lunar
var PI = Math.PI;

function INT(d) {
    return Math.floor(d);
}
function jdFromDate(dd, mm, yy) {
    var a, y, m, jd;
    a = INT((14 - mm) / 12);
    y = yy + 4800 - a;
    m = mm + 12 * a - 3;
    jd =
            dd +
            INT((153 * m + 2) / 5) +
            365 * y +
            INT(y / 4) -
            INT(y / 100) +
            INT(y / 400) -
            32045;
    if (jd < 2299161) {
        jd = dd + INT((153 * m + 2) / 5) + 365 * y + INT(y / 4) - 32083;
    }
    return jd;
}

/* Convert a Julian day number to day/month/year. Parameter jd is an integer */
function jdToDate(jd) {
    var a, b, c, d, e, m, day, month, year;
    if (jd > 2299160) {
        // After 5/10/1582, Gregorian calendar
        a = jd + 32044;
        b = INT((4 * a + 3) / 146097);
        c = a - INT((b * 146097) / 4);
    } else {
        b = 0;
        c = jd + 32082;
    }
    d = INT((4 * c + 3) / 1461);
    e = c - INT((1461 * d) / 4);
    m = INT((5 * e + 2) / 153);
    day = e - INT((153 * m + 2) / 5) + 1;
    month = m + 3 - 12 * INT(m / 10);
    year = b * 100 + d - 4800 + INT(m / 10);
    return new Array(day, month, year);
}
function NewMoon(k) {
    var T, T2, T3, dr, Jd1, M, Mpr, F, C1, deltat, JdNew;
    T = k / 1236.85; // Time in Julian centuries from 1900 January 0.5
    T2 = T * T;
    T3 = T2 * T;
    dr = PI / 180;
    Jd1 = 2415020.75933 + 29.53058868 * k + 0.0001178 * T2 - 0.000000155 * T3;
    Jd1 = Jd1 + 0.00033 * Math.sin((166.56 + 132.87 * T - 0.009173 * T2) * dr); // Mean new moon
    M = 359.2242 + 29.10535608 * k - 0.0000333 * T2 - 0.00000347 * T3; // Sun's mean anomaly
    Mpr = 306.0253 + 385.81691806 * k + 0.0107306 * T2 + 0.00001236 * T3; // Moon's mean anomaly
    F = 21.2964 + 390.67050646 * k - 0.0016528 * T2 - 0.00000239 * T3; // Moon's argument of latitude
    C1 =
            (0.1734 - 0.000393 * T) * Math.sin(M * dr) +
            0.0021 * Math.sin(2 * dr * M);
    C1 = C1 - 0.4068 * Math.sin(Mpr * dr) + 0.0161 * Math.sin(dr * 2 * Mpr);
    C1 = C1 - 0.0004 * Math.sin(dr * 3 * Mpr);
    C1 = C1 + 0.0104 * Math.sin(dr * 2 * F) - 0.0051 * Math.sin(dr * (M + Mpr));
    C1 =
            C1 -
            0.0074 * Math.sin(dr * (M - Mpr)) +
            0.0004 * Math.sin(dr * (2 * F + M));
    C1 =
            C1 -
            0.0004 * Math.sin(dr * (2 * F - M)) -
            0.0006 * Math.sin(dr * (2 * F + Mpr));
    C1 =
            C1 +
            0.001 * Math.sin(dr * (2 * F - Mpr)) +
            0.0005 * Math.sin(dr * (2 * Mpr + M));
    if (T < -11) {
        deltat =
                0.001 +
                0.000839 * T +
                0.0002261 * T2 -
                0.00000845 * T3 -
                0.000000081 * T * T3;
    } else {
        deltat = -0.000278 + 0.000265 * T + 0.000262 * T2;
    }
    JdNew = Jd1 + C1 - deltat;
    return JdNew;
}

function SunLongitude(jdn) {
    var T, T2, dr, M, L0, DL, L;
    T = (jdn - 2451545.0) / 36525; // Time in Julian centuries from 2000-01-01 12:00:00 GMT
    T2 = T * T;
    dr = PI / 180; // degree to radian
    M = 357.5291 + 35999.0503 * T - 0.0001559 * T2 - 0.00000048 * T * T2; // mean anomaly, degree
    L0 = 280.46645 + 36000.76983 * T + 0.0003032 * T2; // mean longitude, degree
    DL = (1.9146 - 0.004817 * T - 0.000014 * T2) * Math.sin(dr * M);
    DL =
            DL +
            (0.019993 - 0.000101 * T) * Math.sin(dr * 2 * M) +
            0.00029 * Math.sin(dr * 3 * M);
    L = L0 + DL; // true longitude, degree
    L = L * dr;
    L = L - PI * 2 * INT(L / (PI * 2)); // Normalize to (0, 2*PI)
    return L;
}

function getSunLongitude(dayNumber, timeZone) {
    return INT((SunLongitude(dayNumber - 0.5 - timeZone / 24) / PI) * 6);
}

function getNewMoonDay(k, timeZone) {
    return INT(NewMoon(k) + 0.5 + timeZone / 24);
}

/* Find the day that starts the luner month 11 of the given year for the given time zone */
function getLunarMonth11(yy, timeZone) {
    var k, off, nm, sunLong;
    //off = jdFromDate(31, 12, yy) - 2415021.076998695;
    off = jdFromDate(31, 12, yy) - 2415021;
    k = INT(off / 29.530588853);
    nm = getNewMoonDay(k, timeZone);
    sunLong = getSunLongitude(nm, timeZone); // sun longitude at local midnight
    if (sunLong >= 9) {
        nm = getNewMoonDay(k - 1, timeZone);
    }
    return nm;
}

/* Find the index of the leap month after the month starting on the day a11. */
function getLeapMonthOffset(a11, timeZone) {
    var k, last, arc, i;
    k = INT((a11 - 2415021.076998695) / 29.530588853 + 0.5);
    last = 0;
    i = 1; // We start with the month following lunar month 11
    arc = getSunLongitude(getNewMoonDay(k + i, timeZone), timeZone);
    do {
        last = arc;
        i++;
        arc = getSunLongitude(getNewMoonDay(k + i, timeZone), timeZone);
    } while (arc !== last && i < 14);
    return i - 1;
}

/* Comvert solar date dd/mm/yyyy to the corresponding lunar date */
function convertSolar2Lunar(dd, mm, yy, timeZone) {
    var k,
            dayNumber,
            monthStart,
            a11,
            b11,
            lunarDay,
            lunarMonth,
            lunarYear,
            lunarLeap;
    dayNumber = jdFromDate(dd, mm, yy);
    k = INT((dayNumber - 2415021.076998695) / 29.530588853);
    monthStart = getNewMoonDay(k + 1, timeZone);
    if (monthStart > dayNumber) {
        monthStart = getNewMoonDay(k, timeZone);
    }
    //alert(dayNumber+" -> "+monthStart);
    a11 = getLunarMonth11(yy, timeZone);
    b11 = a11;
    if (a11 >= monthStart) {
        lunarYear = yy;
        a11 = getLunarMonth11(yy - 1, timeZone);
    } else {
        lunarYear = yy + 1;
        b11 = getLunarMonth11(yy + 1, timeZone);
    }
    lunarDay = dayNumber - monthStart + 1;
    diff = INT((monthStart - a11) / 29);
    lunarLeap = 0;
    lunarMonth = diff + 11;
    if (b11 - a11 > 365) {
        leapMonthDiff = getLeapMonthOffset(a11, timeZone);
        if (diff >= leapMonthDiff) {
            lunarMonth = diff + 10;
            if (diff === leapMonthDiff) {
                lunarLeap = 1;
            }
        }
    }
    if (lunarMonth > 12) {
        lunarMonth = lunarMonth - 12;
    }
    if (lunarMonth >= 11 && diff < 4) {
        lunarYear -= 1;
    }
    return new Array(lunarDay, lunarMonth, lunarYear, lunarLeap);
}

/* Convert a lunar date to the corresponding solar date */
function convertLunar2Solar(
        lunarDay,
        lunarMonth,
        lunarYear,
        lunarLeap,
        timeZone
        ) {
    var k, a11, b11, off, leapOff, leapMonth, monthStart;
    if (lunarMonth < 11) {
        a11 = getLunarMonth11(lunarYear - 1, timeZone);
        b11 = getLunarMonth11(lunarYear, timeZone);
    } else {
        a11 = getLunarMonth11(lunarYear, timeZone);
        b11 = getLunarMonth11(lunarYear + 1, timeZone);
    }
    k = INT(0.5 + (a11 - 2415021.076998695) / 29.530588853);
    off = lunarMonth - 11;
    if (off < 0) {
        off += 12;
    }
    if (b11 - a11 > 365) {
        leapOff = getLeapMonthOffset(a11, timeZone);
        leapMonth = leapOff - 2;
        if (leapMonth < 0) {
            leapMonth += 12;
        }
        if (lunarLeap !== 0 && lunarMonth !== leapMonth) {
            return new Array(0, 0, 0);
        } else if (lunarLeap !== 0 || off >= leapOff) {
            off += 1;
        }
    }
    monthStart = getNewMoonDay(k + off, timeZone);
    return jdToDate(monthStart + lunarDay - 1);
}

const solarDay = 14;
const solarMonth = 1;
const solarYear = 2024;
const solarTimeZone = 7; //GMT+7

const lunarDate = convertSolar2Lunar(
        solarDay,
        solarMonth,
        solarYear,
        solarTimeZone
        );

console.log(
        `Solar date: ${solarDay}/${solarMonth}/${solarYear} - Lunar date: ${lunarDate[0]
        }/${lunarDate[1]}/${lunarDate[2]}${lunarDate[3] ? ' (leap month)' : ''}`
        );