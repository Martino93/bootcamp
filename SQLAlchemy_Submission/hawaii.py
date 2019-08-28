import numpy as np
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func
from flask import Flask, jsonify
import os
from datetime import timedelta, datetime as dt

engine=create_engine("sqlite:///Resources/hawaii.sqlite")
Base=automap_base()
Base.prepare(engine,reflect=True)

Measurement = Base.classes.measurement
Station = Base.classes.station
session = Session(engine)

app=Flask(__name__)

@app.route("/")
def welcome():
    return(
    f'Available Routes:<br/>'
    f'/api/v1.0/precipitation<br/>' 
    f'/api/v1.0/stations <br/>' 
    f'/api/v1.0/tobs <br/>' 
    f'/api/v1.0/<start> <br/>' 
    f'/api/v1.0/<start>/<end> <br/>' 
    )


@app.route('/api/v1.0/precipitation')
def precipitation():
    results = engine.execute('select measurement.date, measurement.prcp from measurement').fetchall()
    date_precip = []
    for date,precip in results:
        precip_dict = {}
        precip_dict['date'] = date
        precip_dict['precip'] = precip
        date_precip.append(precip_dict)
    return jsonify(date_precip)

        
@app.route('/api/v1.0/stations')
def stations():
    stations = engine.execute('select station.name from station').fetchall()
    return jsonify(list(np.ravel(stations)))
    

@app.route('/api/v1.0/tobs')
def last_year():
    end_date = dt(2017,8,31)
    start_date = end_date - timedelta(days=365)

    last_year_results = np.ravel(session.query(Measurement.date, Measurement.tobs).filter(Measurement.date>=start_date).\
                                 filter(Measurement.date<=end_date).all())
    return jsonify(list(last_year_results))


@app.route('/api/v1.0/<start>')
def start_date(start):
    results = list(np.ravel(session.query(Measurement.date, func.min(Measurement.tobs), func.avg(Measurement.tobs),\
              func.max(Measurement.tobs)).filter(Measurement.date>=start).all()))
    return jsonify(results)
    
    
@app.route('/api/v1.0/<start>/<end>')
def start_end(start,end):
    results2 = list(np.ravel(session.query(Measurement.date, func.min(Measurement.tobs), func.avg(Measurement.tobs),\
              func.max(Measurement.tobs)).filter(Measurement.date>=start).filter(Measurement.date<=end).all()))
    return jsonify(results2)


        
if __name__ == '__main__':
    app.run(host=os.getenv('IP', '0.0.0.0'), port=int(os.getenv('PORT',4444)), debug=True)