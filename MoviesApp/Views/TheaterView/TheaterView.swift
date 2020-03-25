//
//  TheaterView.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 22/03/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import SwiftUI

struct TheaterView: View {
    @ObservedObject var viewModel: TheatreViewModel = TheatreViewModel()
    
    var body: some View {
        List() {
            ZStack {
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.accentColor.opacity(0.7), .clear]), startPoint: UnitPoint(x: 0.0, y: 0.0), endPoint: UnitPoint(x: 0.0, y: 0.9)))
                    .frame(height: 150)
                    .clipShape(ScreenShape(isClip: true))
                    .cornerRadius(20)
                ScreenShape()
                    .stroke(style:  StrokeStyle(lineWidth: 5,  lineCap: .square ))
                    .frame(height: 150)
                    .foregroundColor(Color.accentColor)
            }
            SeatView(viewModel: viewModel)
            MovieShowDateView(selectedIndex: 3)
            MovieShowTimeView(selectedIndex: 2)
            Button(action: {
                print("Selected Seats")
                print(self.viewModel.selectedSeats)
            }) {
                Text("Continue")
            }
            .frame(minWidth: 100, maxWidth: .infinity, minHeight: 50, maxHeight: 50)
            .background(Color.blue)
            .cornerRadius(10)
            .padding(.vertical)
        }
    }
}

struct SeatView: View {
    @ObservedObject var viewModel: TheatreViewModel
    
    var body: some View {
        VStack(spacing: 25) {
            ScrollView(.horizontal, showsIndicators: true) {
                VStack {
                    ForEach(0..<10, id: \.self) { col in
                        HStack{
                            ForEach(0..<14, id: \.self){ row in
                                ChairView(availableState: (self.viewModel.selectedSeats.contains((col * 10) + row)) ? .selected : .available).onTapGesture {
                                    let seatNumber = ((col * 10) + row)
                                    if self.viewModel.selectedSeats.contains(seatNumber) {
                                        if let index: Int = self.viewModel.selectedSeats.firstIndex(of: seatNumber) {
                                            self.viewModel.selectedSeats.remove(at: index)
                                        }
                                    } else {
                                        self.viewModel.selectedSeats.append(seatNumber)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            HStack(spacing: 20) {
                HStack {
                    ChairView(availableState: .available)
                    Text("Available")
                        .foregroundColor(.gray)
                }
                HStack {
                    ChairView(availableState: .selected)
                    Text("Selected")
                        .foregroundColor(.accentColor)
                }
                HStack {
                    ChairView(availableState: .reserved)
                    Text("Reserved")
                        .foregroundColor(.purple)
                }
            }
        }
    }
}

struct ChairView: View {
    enum AvailableState {
        case available
        case selected
        case reserved
    }
    
    var availableState: AvailableState = .available
    
    var body: some View {
        VStack(spacing: 2) {
            if availableState == .available {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(.gray)
                    .frame(width: 30, height: 20)
                
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(.gray)
                    .frame(width: 25, height: 10)
            } else if availableState == .selected {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(.accentColor)
                    .frame(width: 30, height: 20)
                
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(.accentColor)
                    .frame(width: 25, height: 10)
            } else {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(.purple)
                    .frame(width: 30, height: 20)
                
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(.purple)
                    .frame(width: 25, height: 10)
            }
        }
    }
}

struct ScreenShape: Shape {
    var screenCurveture: CGFloat = 30
    var isClip = false
    
    func path(in rect: CGRect) -> Path {
        
        return Path{ path in
            path.move(to: CGPoint(x: rect.origin.x + screenCurveture, y: rect.origin.y +  screenCurveture))
            path.addQuadCurve(to: CGPoint(x: rect.width - screenCurveture, y: rect.origin.y + screenCurveture), control: CGPoint(x: rect.midX, y: rect.origin.y) )
            if isClip {
                path.addLine(to: CGPoint(x: rect.width, y: rect.height))
                path.addLine(to: CGPoint(x: rect.origin.x, y: rect.height))
                path.closeSubpath()
            }
        }
    }
}

struct MovieShowDateView: View {
    var selectedIndex: Int
    
    var dateDataSource: [DateDataSource] {
        var dates: [DateDataSource] = []
        
        for day in 0..<7 {
            let date: Date = Calendar.current.date(byAdding: .day, value: day, to: Date()) ?? Date()
            let dateString = date.convertToString()
            let dateStringArray = dateString.components(separatedBy: " ")
            let dateData: DateDataSource = DateDataSource(id: day, day: dateStringArray[0], month: dateStringArray[1])
            dates.append(dateData)
        }
        
        return dates
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Date")
                .font(.headline)
                .foregroundColor(.primary)
                .padding(.top)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(dateDataSource, id: \.id) { day in
                        VStack {
                            Text(day.day)
                                .foregroundColor(.white)
                                .font(.title)
                                .padding()
                            Text(day.month)
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                        .frame(width: 80, height: 110)
                        .background((self.selectedIndex - 1) == day.id ? Color.accentColor : Color.gray)
                        .cornerRadius(10)
                    }
                }
            }
        }
    }
}

struct MovieShowTimeView: View {
    var selectedIndex: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Time")
                .font(.headline)
                .foregroundColor(.primary)
                .padding(.top)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<7, id: \.self) { index in
                        Text("10:30 PM")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .background((self.selectedIndex - 1) == index ? Color.accentColor : Color.gray)
                            .cornerRadius(10)
                    }
                }
            }
        }
    }
}

struct TheaterView_Previews: PreviewProvider {
    static var previews: some View {
        TheaterView()
    }
}
